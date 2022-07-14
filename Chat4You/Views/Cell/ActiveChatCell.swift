//
//  ActiveChatCell.swift
//  Chat4You
//
//  Created by Alex Kulish on 15.06.2022.
//

import UIKit

class ActiveChatCell: UICollectionViewCell, ConfigureCellProtocol {
    
    static var reuseId = "ActiveChatCell"
    
    private lazy var friendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var friendName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .laoSangamMN20()
        return label
    }()
    
    private lazy var lastMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .laoSangamMN18()
        return label
    }()
    
    private lazy var gradientView: UIView = {
        let view = GradientView(from: .topTrailing, to: .bottomLeading, startColor: .customPurple, endColor: .customBlue)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        backgroundColor = .white
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let chat: MChat = value as? MChat else { return }
        friendImageView.image = UIImage(named: chat.friendUserImageStringURL)
        friendName.text = chat.friendUserName
        lastMessage.text = chat.lastMessage
    }
}

// MARK: - Setup constraints

extension ActiveChatCell {
    
    private func addSubviews() {
        addSubview(friendImageView)
        addSubview(gradientView)
        addSubview(friendName)
        addSubview(lastMessage)
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate([
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            friendImageView.widthAnchor.constraint(equalToConstant: 78),
            friendImageView.heightAnchor.constraint(equalToConstant: 78)
        ])
        
        NSLayoutConstraint.activate([
            gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gradientView.widthAnchor.constraint(equalToConstant: 8),
            gradientView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.topAnchor.constraint(equalTo: friendName.bottomAnchor),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16)
        ])
    }
}
