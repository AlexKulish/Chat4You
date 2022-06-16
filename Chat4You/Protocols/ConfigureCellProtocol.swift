//
//  ConfigureCellProtocol.swift
//  Chat4You
//
//  Created by Alex Kulish on 16.06.2022.
//

import Foundation

protocol ConfigureCellProtocol {
    static var reuseId: String { get }
    func configure(with chat: MChat)
}
