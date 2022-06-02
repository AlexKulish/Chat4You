//
//  SetupProfileViewController.swift
//  Chat4You
//
//  Created by Alex Kulish on 02.06.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let fullPhotoView = AddPhotoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
}

// MARK: - Setup constraints

extension SetupProfileViewController {
    
    private func setupConstraints() {
        fullPhotoView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fullPhotoView)
        
        NSLayoutConstraint.activate([
            fullPhotoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            fullPhotoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
}
