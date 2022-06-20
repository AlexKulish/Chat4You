//
//  UserCell.swift
//  Chat4You
//
//  Created by Alex Kulish on 20.06.2022.
//

import UIKit

class UserCell: UICollectionViewCell, ConfigureCellProtocol {
    
    static var reuseId = "UserCell"
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .laoSangamMN20()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userImageView)
        view.addSubview(userNameLabel)
        addSubview(view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
    }
    
    private func setupShadow() {
        layer.cornerRadius = 4
        layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let user = value as? MUser else { return }
        userImageView.image = UIImage(named: user.avatarStringURL)
        userNameLabel.text = user.username
    }
    
    
}
