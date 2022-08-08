//
//  UserError.swift
//  Chat4You
//
//  Created by Alex Kulish on 06.07.2022.
//

import Foundation

enum UserError {
    case notFill
    case photoNotExist
    case cannotGetUserInfo
    case cannotUnwrapToMUser
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFill:
            return NSLocalizedString("Fill all fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("User has not selected a photo", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Unable to find user information in the database", comment: "")
        case .cannotUnwrapToMUser:
            return NSLocalizedString("Can't convert MUser model", comment: "")

        }
    }
}
