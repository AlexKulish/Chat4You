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
    var friendId: String
    
    var representation: [String: Any] {
        var dict = ["friendUserName": friendUserName]
        dict["friendUserImageStringURL"] = friendUserImageStringURL
        dict["lastMessage"] = lastMessage
        dict["friendId"] = friendId
        return dict
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        lhs.friendId == rhs.friendId
    }
}
