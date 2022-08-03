//
//  MMessage.swift
//  Chat4You
//
//  Created by Alex Kulish on 14.07.2022.
//

import Foundation
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
    
    var sender: SenderType
    let content: String
    let id: String?
    var sentDate: Date
    var messageId: String {
        id ?? UUID().uuidString
    }
    var kind: MessageKind {
        .text(content)
    }
    
    var representation: [String: Any] {
        let dict: [String: Any] = [
            "created": sentDate,
            "content": content,
            "senderName": sender.displayName,
            "senderID": sender.senderId
        ]
        return dict
    }

    init(user: MUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.userName)
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let content = data["content"] as? String,
              let senderId = data["senderID"] as? String,
              let senderUserName = data["senderName"] as? String,
              let sentDate = data["created"] as? Timestamp else { return nil }
        
        self.content = content
        sender = Sender(senderId: senderId, displayName: senderUserName)
        self.sentDate = sentDate.dateValue()
        self.id = document.documentID
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.messageId == rhs.messageId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
}
