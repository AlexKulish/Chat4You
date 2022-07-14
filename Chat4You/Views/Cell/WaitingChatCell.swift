//
//  WaitingChatCell.swift
//  Chat4You
//
//  Created by Alex Kulish on 16.06.2022.
//

import UIKit

class WaitingChatCell: UICollectionViewCell, ConfigureCellProtocol {
    
    static var reuseId = "WaitingChatCell"
    
    private lazy var friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(friendImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat = value as? MChat else { return }
        friendImageView.image = UIImage(named: chat.friendUserImageStringURL)
    }
}

// MARK: - Setup constraints

extension WaitingChatCell {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
