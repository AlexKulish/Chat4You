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
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFill:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        }
    }
}
