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
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Не удается найти информацию по пользователю в базе данных", comment: "")
        case .cannotUnwrapToMUser:
            return NSLocalizedString("Не удается конвертировать модель MUser", comment: "")

        }
    }
}
