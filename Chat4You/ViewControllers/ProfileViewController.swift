//
//  ProfileViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 22.06.2022.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private let user: MUser
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite
        view.layer.cornerRadius = 30
        view.addSubview(nameLabel)
        view.addSubview(aboutMeLabel)
        view.addSubview(textField)
        return view
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "human4"), contentMode: .scaleAspectFill)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(text: "Alex Kulish", font: .systemFont(ofSize: 20, weight: .light))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var aboutMeLabel: UILabel = {
        let label = UILabel(text: "Hello, my name is Alex", font: .systemFont(ofSize: 16, weight: .light))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = CustomTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(user: MUser) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        self.nameLabel.text = user.userName
        self.aboutMeLabel.text = user.description
        guard let url = URL(string: user.avatarStringURL) else { return }
        self.userImageView.sd_setImage(with: url, completed: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        addSubviews()
        setupConstraints()
        getButton()
        setupNotificationKeyboardObservers()
    }
    
}

// MARK: - Setup constraints

extension ProfileViewController {
    
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
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -40),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}

// MARK: - Setup button action

extension ProfileViewController {
    
    private func getButton() {
        guard let rightButton = textField.rightView as? UIButton else { return }
        rightButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
    }
    
    @objc private func sendMessage() {
        guard let message = textField.text, message != "" else { return }
        
        self.dismiss(animated: true) {
            FirestoreService.shared.createWaitingChat(message: message, receiver: self.user) { result in
                switch result {
                case .success():
                    UIApplication.getTopViewController()?.showAlert(with: "Success", and: "Your message for \(self.user.userName) has been delivered")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "Error", and: error.localizedDescription)
                }
            }
        }
    }
    
}

// MARK: - Setup Notification Keyboard Observers

extension ProfileViewController {
    
    private func setupNotificationKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
