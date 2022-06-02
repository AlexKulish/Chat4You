//
//  MainTabBarController.swift
//  Chat4You
//
//  Created by Alex Kulish on 02.06.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let peopleVC = PeopleViewController()
        let listVC = ListViewController()
        
        tabBar.tintColor = .customPurple
        let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)
        let conversationImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)
        
        viewControllers = [
            setupNavigationController(rootViewController: peopleVC, title: "People", image: peopleImage ?? UIImage()),
            setupNavigationController(rootViewController: listVC, title: "Conversations", image: conversationImage ?? UIImage())
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
}
