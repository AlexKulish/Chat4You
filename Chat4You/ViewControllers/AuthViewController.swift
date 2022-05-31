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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customBlack
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
