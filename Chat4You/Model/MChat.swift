//
//  MChat.swift
//  Chat4You
//
//  Created by Alex Kulish on 15.06.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
    var userName: String
    var userImageString: String
    var lastMessage: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        lhs.id == rhs.id
    }
}
