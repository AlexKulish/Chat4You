//
//  MChat.swift
//  Chat4You
//
//  Created by Alex Kulish on 15.06.2022.
//

import Foundation

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendUserImageStringURL: String
    var lastMessage: String
    var friendId: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        lhs.friendId == rhs.friendId
    }
}
