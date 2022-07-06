//
//  Validators.swift
//  Chat4You
//
//  Created by Alex Kulish on 05.07.2022.
//

import Foundation

class Validators {
    
    static func isFill(email: String?, password: String?, confirmPassword: String?) -> Bool {
        
        guard let email = email,
              let password = password,
              let confirmPassword = confirmPassword,
              email != "",
              password != "",
              confirmPassword != "" else {
                  return false
              }
        
        return true
    }
    
    static func isFill(userName: String?, description: String?, sex: String?) -> Bool {
        
        guard let userName = userName,
              let description = description,
              let sex = sex,
              userName != "",
              description != "",
              sex != "" else {
                  return false
              }
        
        return true
    }
    
    // объяснение как работает валидация www.advancedswift.com/regular-expressions/
    // еще один пример medium.com/swlh/password-validation-in-swift-5-3de161569910
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = #"^\S+@\S+\.\S+$"#
        return check(text: email, regEx: emailRegEx)
    }
    
    static func isSimplePassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$"
        return check(text: password, regEx: passwordRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
}
