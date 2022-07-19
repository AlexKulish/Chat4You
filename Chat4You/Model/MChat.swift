//
//  MChat.swift
//  Chat4You
//
//  Created by Alex Kulish on 15.06.2022.
//

import Foundation
import FirebaseFirestore

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
    
    init(friendUserName: String, friendUserImageStringURL: String, lastMessage: String, friendId: String) {
        self.friendUserName = friendUserName
        self.friendUserImageStringURL = friendUserImageStringURL
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName = data["friendUserName"] as? String,
              let friendUserImageStringURL = data["friendUserImageStringURL"] as? String,
              let lastMessage = data["lastMessage"] as? String,
              let friendId = data["friendId"] as? String else { return nil }
        
        self.friendUserName = friendUserName
        self.friendUserImageStringURL = friendUserImageStringURL
        self.lastMessage = lastMessage
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        lhs.friendId == rhs.friendId
    }
}
