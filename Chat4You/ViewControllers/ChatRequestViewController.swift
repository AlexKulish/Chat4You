//
//  ChatRequestViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 24.06.2022.
//

import UIKit
import SDWebImage

class ChatRequestViewController: UIViewController {
    
    weak var delegate: WaitingChatsDelegate?
    
    private let chat: MChat
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite
        view.layer.cornerRadius = 30
        view.addSubview(nameLabel)
        view.addSubview(aboutMeLabel)
        view.addSubview(stackView)
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .clear, font: .laoSangamMN20(), cornerRadius: 10)
        button.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var denyButton: UIButton = {
        let button = UIButton(title: "Deny", titleColor: #colorLiteral(red: 0.8756850362, green: 0.2895075083, blue: 0.2576965988, alpha: 1), backgroundColor: .customWhite, font: .laoSangamMN20(), cornerRadius: 10)
        button.layer.borderWidth = 1.2
        button.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
        button.addTarget(self, action: #selector(denyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(chat: MChat) {
        self.chat = chat
        super.init(nibName: nil, bundle: nil)
        nameLabel.text = chat.friendUserName
        aboutMeLabel.text = chat.lastMessage
        guard let url = URL(string: chat.friendUserImageStringURL) else { return }
        userImageView.sd_setImage(with: url, completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradients(with: 10)
    }
    
    @objc private func acceptButtonPressed() {
        self.dismiss(animated: true) {
            self.delegate?.chatToActive(chat: self.chat)
        }
    }
    
    @objc private func denyButtonPressed() {
        self.dismiss(animated: true) {
            self.delegate?.removeWaitingChat(chat: self.chat)
        }
    }
}

// MARK: - Setup contraints

extension ChatRequestViewController {
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(containerView)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.topAnchor),
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userImageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 205)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35)
        ])
        
        NSLayoutConstraint.activate([
            aboutMeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            aboutMeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            aboutMeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}
