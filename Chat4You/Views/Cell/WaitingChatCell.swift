//
//  WaitingChatCell.swift
//  Chat4You
//
//  Created by Alex Kulish on 16.06.2022.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, ConfigureCellProtocol {
    
    // MARK: - Public properties
    
    static var reuseId = "WaitingChatCell"
    
    // MARK: - Private properties
    
    private lazy var friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(friendImageView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat = value as? MChat else { return }
        guard let url = URL(string: chat.friendUserImageStringURL) else { return }
        friendImageView.sd_setImage(with: url, completed: nil)
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
