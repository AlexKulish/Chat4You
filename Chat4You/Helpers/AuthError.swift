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
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmal:
            return NSLocalizedString("Формат почты не является допустимым", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Неверный формат пароля: Пароль должен содержать минимум 6 символов, одну большую букву, одну маленькую и одну цифру", comment: "")
        case .passwordNotMatches:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка на сервере", comment: "")
        }
    }
    
}
