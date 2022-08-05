//
//  MMessage.swift
//  Chat4You
//
//  Created by Alex Kulish on 14.07.2022.
//

import Foundation
import FirebaseFirestore
import MessageKit
import UIKit

struct MMessage: Hashable, MessageType {
    
    var sender: SenderType
    let content: String
    let id: String?
    var sentDate: Date
    var messageId: String {
        id ?? UUID().uuidString
    }
    var kind: MessageKind {
        if let image = image {
            let mediaItem = ImageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(mediaItem)
        } else {
            return .text(content)
        }
    }
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil
    
    var representation: [String: Any] {
        var dict: [String: Any] = [
            "created": sentDate,
            "senderName": sender.displayName,
            "senderID": sender.senderId
        ]
        
        if let downloadURL = downloadURL {
            dict["url"] = downloadURL.absoluteString
        } else {
            dict["content"] = content
        }
        return dict
    }

    init(user: MUser, content: String) {
        self.content = content
        sender = Sender(senderId: user.id, displayName: user.userName)
        sentDate = Date()
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sender = Sender(senderId: user.id, displayName: user.userName)
        self.image = image
        content = ""
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let senderId = data["senderID"] as? String,
              let senderUserName = data["senderName"] as? String,
              let sentDate = data["created"] as? Timestamp else { return nil }
        
        if let content = data["content"] as? String {
            self.content = content
            downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            downloadURL = url
            self.content = ""
        } else {
            return nil
        }
        
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

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.sentDate < rhs.sentDate
    }
}
