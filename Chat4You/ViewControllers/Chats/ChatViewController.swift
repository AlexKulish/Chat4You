//
//  ChatViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 03.08.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import FirebaseFirestore

class ChatViewController: MessagesViewController {
    
    private let user: MUser
    private let chat: MChat
    
    private var messages: [MMessage] = []
    private var messageListener: ListenerRegistration?
    
    init(user: MUser, chat: MChat) {
        self.user = user
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        title = chat.friendUserName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        messageListener?.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMessageInputBar()
        reworkLayoutOfMessage()
        setupMessageListener()
        
        messagesCollectionView.backgroundColor = .customWhite
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    private func insertNewMessage(message: MMessage) {
        
        guard !messages.contains(message) else { return }
        messages.append(message)
        messages.sort()
        
        let isLastMessage = messages.firstIndex(of: message) == (messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLastMessage
        
        messagesCollectionView.reloadData()
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToLastItem()
            }
        }
    }
    
    private func reworkLayoutOfMessage() {
        // Чтобы убрать расстояние между сообщением и правой частью экрана
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    private func setupMessageListener() {
        messageListener = ListenerService.shared.messagesObserve(chat: chat, completion: { [weak self] result in
            switch result {
            case .success(let message):
                self?.insertNewMessage(message: message)
            case .failure(let error):
                self?.showAlert(with: "Error!", and: error.localizedDescription)
            }
        })
    }
    
}

// MARK: - ConfigureMessageInputBar

extension ChatViewController {
    
    private func configureMessageInputBar() {
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .customWhite
        messageInputBar.inputTextView.backgroundColor = .white
        messageInputBar.inputTextView.placeholderTextColor = .customGray
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
        messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0.6753501223, green: 0.7336379003, blue: 0.7513690994, alpha: 1)
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        messageInputBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        messageInputBar.layer.shadowRadius = 5
        messageInputBar.layer.shadowOpacity = 0.3
        messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        configureSendButton()
    }
    
    private func configureSendButton() {
        messageInputBar.sendButton.setImage(UIImage(named: "Sent"), for: .normal)
        messageInputBar.sendButton.applyGradients(with: 10)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 30)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
        messageInputBar.middleContentViewPadding.right = -38
    }
}

// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        Sender(senderId: user.id, displayName: user.userName)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let messageFormatter = MessageKitDateFormatter.shared.string(from: message.sentDate)
        
        let attributes: [NSAttributedString.Key: Any]? = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        
        if indexPath.item % 5 == 0 {
            return NSAttributedString(string: messageFormatter, attributes: attributes)
        } else {
            return nil
        }
    }
    
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        CGSize(width: 0, height: 8)
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.item % 5 == 0 {
            return 30
        } else {
            return 0
        }
    }
    
}

// MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .white : .customPurple
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .black : .white
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        .zero
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        .bubble
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        let message = MMessage(user: user, content: text)
        FirestoreService.shared.sendMessage(chat: chat, message: message) { result in
            switch result {
            case .success():
                self.messagesCollectionView.scrollToLastItem()
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
        inputBar.inputTextView.text = ""
    }
    
}
