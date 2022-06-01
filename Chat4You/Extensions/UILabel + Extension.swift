//
//  UILabel + Extension.swift
//  Chat4You
//
//  Created by Alex Kulish on 31.05.2022.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        self.text = text
        self.font = font
    }
    
}
