//
//  ImageItem.swift
//  Chat4You
//
//  Created by Alex Kulish on 05.08.2022.
//

import Foundation
import MessageKit

struct ImageItem: MediaItem {
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
