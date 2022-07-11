//
//  ViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 31.05.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .customBlack)
    let loginButton = UIButton(title: "Login", titleColor: .customRed, backgroundColor: .white, isShadow: true)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Or sign up with")
    let alreadyOnBoardLabel = UILabel(text: "Already onboard?")
    
    let logoImageView = UIImageView(image: UIImage(named: "Logo"), contentMode: .scaleAspectFit)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite
        setupConstraints()
        setupPresentationStyleForVC()
        
        loginVC.delegate = self
        signUpVC.delegate = self
        
        emailButton.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
    }
    
    @objc private func emailButtonPressed() {
        present(signUpVC, animated: true, completion: nil)
    }
    
    @objc private func loginButtonPressed() {
        present(loginVC, animated: true, completion: nil)
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
    
    private func setupPresentationStyleForVC() {
        loginVC.modalPresentationStyle = .fullScreen
        signUpVC.modalPresentationStyle = .fullScreen
    }
    
}

// MARK: - AuthNavigationDelegate

extension AuthViewController: AuthNavigationDelegate {
    
    func toLoginVC() {
        present(loginVC, animated: true, completion: nil)
    }
    
    func toSignUpVC() {
        present(signUpVC, animated: true, completion: nil)
    }
    
}

// MARK: - Setup constraints

extension AuthViewController {
    private func setupConstraints() {
        googleButton.costomizeGoogleButton()
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnBoardLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView], axis: .vertical, spacing: 40)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        view.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -40)
        ])
    }
}

// MARK: - SwiftUI

import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = AuthViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
    }
    
}
