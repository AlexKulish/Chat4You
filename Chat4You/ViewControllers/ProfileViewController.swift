//
//  ProfileViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 22.06.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
        let label = UILabel(text: "Hello, my friend asdasd asdasd asdasd aasd asasd dasd ", font: .systemFont(ofSize: 16, weight: .light))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Add your opinion"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
    }
    
}

// MARK: - Setup constraints

extension ProfileViewController {
    
    private func setupConstraints() {
        view.addSubview(userImageView)
        view.addSubview(containerView)
        
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
            textField.topAnchor.constraint(equalTo: aboutMeLabel.bottomAnchor, constant: 8),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}
