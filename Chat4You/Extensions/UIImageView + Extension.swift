//
//  UIImageView + Extension.swift
//  Chat4You
//
//  Created by Alex Kulish on 31.05.2022.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
}
