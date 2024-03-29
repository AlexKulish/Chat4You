//
//  LoginViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 02.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: AuthNavigationDelegate?
    
    // MARK: - Private properties
    
    private let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    private let loginWithLabel = UILabel(text: "Login with")
    private let orLabel = UILabel(text: "or")
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    private let needAnAccountLabel = UILabel(text: "Need an account?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .customBlack)
    private let signUpButton = UIButton(title: "Sign up", titleColor: .customRed, backgroundColor: .clear)
    
    private let emailTextField = OneLineTextField(font: .avenir20())
    private let passwordTextField = OneLineTextField(font: .avenir20())
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        setupConstraints()
        setupNotificationKeyboardObservers()
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Private methods
    
    @objc private func loginButtonPressed() {
        
        AuthService.shared.login(email: emailTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .success(let user):
                self.showAlert(with: "Success!", and: "You are logged in!") {
                    FirestoreService.shared.getUserData(user: user) { result in
                        switch result {
                        case .success(let mUser):
                            let mainTabBarVC = MainTabBarController(currentUser: mUser)
                            mainTabBarVC.modalPresentationStyle = .fullScreen
                            self.present(mainTabBarVC, animated: true, completion: nil)
                        case .failure(_):
                            let setupProfileVC = SetupProfileViewController(currentUser: user)
                            setupProfileVC.modalPresentationStyle = .fullScreen
                            self.present(setupProfileVC, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func googleButtonPressed() {
        AuthService.shared.loginWithGoogle(viewController: self) { result in
            switch result {
            case .success(let user):
                FirestoreService.shared.getUserData(user: user) { result in
                    switch result {
                    case .success(let mUser):
                        self.showAlert(with: "Success!", and: "You are logged in!") {
                            let mainTabBarVC = MainTabBarController(currentUser: mUser)
                            mainTabBarVC.modalPresentationStyle = .fullScreen
                            self.present(mainTabBarVC, animated: true, completion: nil)
                        }
                    case .failure(_):
                        self.showAlert(with: "Success!", and: "You have successfully registered!") {
                            let setupProfileVC = SetupProfileViewController(currentUser: user)
                            setupProfileVC.modalPresentationStyle = .fullScreen
                            self.present(setupProfileVC, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error!", and: error.localizedDescription)
            }
        }
    }
    
    @objc private func signUpButtonPressed() {
        dismiss(animated: true) {
            self.delegate?.toSignUpVC()
        }
    }
    
}

// MARK: - Setup constraints

extension LoginViewController {
    
    private func setupConstraints() {
        googleButton.costomizeGoogleButton()
        
        emailTextField.autocorrectionType = .no
        passwordTextField.autocorrectionType = .no
        
        passwordTextField.textContentType = .oneTimeCode
        passwordTextField.isSecureTextEntry = true
        
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        
        signUpButton.contentHorizontalAlignment = .leading
        let bottomStackView = UIStackView(arrangedSubviews: [needAnAccountLabel, signUpButton], axis: .horizontal, spacing: 20)
        bottomStackView.alignment = .firstBaseline
        
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [loginWithView, orLabel, emailStackView, passwordStackView, loginButton], axis: .vertical, spacing: 30)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        
    }
    
}

// MARK: - Setup Notification Keyboard Observers

extension LoginViewController {
    
    private func setupNotificationKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 0.4
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

