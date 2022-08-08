//
//  AuthError.swift
//  Chat4You
//
//  Created by Alex Kulish on 05.07.2022.
//

import Foundation

enum AuthError {
    
    case notFill
    case invalidEmal
    case invalidPassword
    case passwordNotMatches
    case unknownError
    case serverError
    
}

extension AuthError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFill:
            return NSLocalizedString("Fill all fields", comment: "")
        case .invalidEmal:
            return NSLocalizedString("Email format is not valid", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Invalid password format: Password must contain at least 6 characters, one uppercase letter, one lowercase letter and one number", comment: "")
        case .passwordNotMatches:
            return NSLocalizedString("Passwords do not match", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown error", comment: "")
        case .serverError:
            return NSLocalizedString("Error on the server", comment: "")
        }
    }
    
}
