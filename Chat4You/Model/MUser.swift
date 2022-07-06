//
//  MUser.swift
//  Chat4You
//
//  Created by Alex Kulish on 20.06.2022.
//

import Foundation

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
