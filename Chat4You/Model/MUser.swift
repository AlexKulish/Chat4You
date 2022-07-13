//
//  MUser.swift
//  Chat4You
//
//  Created by Alex Kulish on 20.06.2022.
//

import Foundation
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var id: String
    var userName: String
    var email: String
    var description: String
    var sex: String
    var avatarStringURL: String
    
    var representation: [String: Any] {
        var dict = ["uid": id]
        dict["userName"] = userName
        dict["email"] = email
        dict["description"] = description
        dict["sex"] = sex
        dict["avatarStringURL"] = avatarStringURL
        return dict
    }
    
    init(id: String, userName: String, email: String, description: String, sex: String, avatarStringURL: String) {
        self.id = id
        self.userName = userName
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let userName = data["userName"] as? String,
              let id = data["uid"] as? String,
              let email = data["email"] as? String,
              let description = data["description"] as? String,
              let sex = data["sex"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        
        self.userName = userName
        self.id = id
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let userName = data["userName"] as? String,
              let id = data["uid"] as? String,
              let email = data["email"] as? String,
              let description = data["description"] as? String,
              let sex = data["sex"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String else { return nil }
        
        self.userName = userName
        self.id = id
        self.email = email
        self.description = description
        self.sex = sex
        self.avatarStringURL = avatarStringURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        
        let lowercasedFilter = filter.lowercased()
        
        return userName.lowercased().contains(lowercasedFilter)
    }
    
}
