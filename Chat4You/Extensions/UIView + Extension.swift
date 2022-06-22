//
//  UIView + Extension.swift
//  Chat4You
//
//  Created by Alex Kulish on 22.06.2022.
//

import UIKit

extension UIView {
    
    func applyGradients(with cornerRadius: CGFloat) {
        
        self.backgroundColor = nil
        self.layoutIfNeeded()
        
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: .customPurple, endColor: .customBlue)
        
        guard let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer else { return }
        
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
