//
//  MMessage.swift
//  Chat4You
//
//  Created by Alex Kulish on 14.07.2022.
//

import Foundation
import FirebaseFirestore

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
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let content = data["content"] as? String,
              let senderId = data["senderID"] as? String,
              let senderUserName = data["senderName"] as? String,
              let sendDate = data["created"] as? Timestamp else { return nil }
        
        self.content = content
        self.senderId = senderId
        self.senderUserName = senderUserName
        self.sendDate = sendDate.dateValue()
        self.id = document.documentID
    }
    
}
