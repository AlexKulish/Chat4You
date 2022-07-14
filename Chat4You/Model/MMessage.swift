//
//  MMessage.swift
//  Chat4You
//
//  Created by Alex Kulish on 14.07.2022.
//

import Foundation

struct MMessage: Hashable {
    
    let content: String
    let senderId: String
    let senderUserName: String
    let id: String?
    var sendDate: Date
    
    var representation: [String: Any] {
        let dict: [String: Any] = [
            "created": sendDate,
            "content": content,
            "senderName": senderUserName,
            "senderID": senderId
        ]
        return dict
    }

    init(user: MUser, content: String) {
        self.content = content
        senderId = user.id
        senderUserName = user.userName
        sendDate = Date()
        id = nil
    }
    
}
