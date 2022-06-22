//
//  CustomTextField.swift
//  Chat4You
//
//  Created by Alex Kulish on 22.06.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "smiley")
        imageView.tintColor = .gray
        return imageView
    }()
    
    private lazy var imageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Sent"), for: .normal)
        button.applyGradients(with: 15)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x -= 12
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 36, dy: 0)
    }
    
    private func setupStyle() {
        backgroundColor = .white
        placeholder = "Write something here..."
        font = .systemFont(ofSize: 14)
        borderStyle = .none
        clearButtonMode = .whileEditing
        layer.cornerRadius = 18
        layer.masksToBounds = true
    }
    
    private func addSubviews() {
        leftView = imageView
        leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        leftViewMode = .always
        
        rightView = imageButton
        rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        rightViewMode = .always
    }
    
}
