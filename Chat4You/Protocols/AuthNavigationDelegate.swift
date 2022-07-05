//
//  AuthNavigationDelegate.swift
//  Chat4You
//
//  Created by Alex Kulish on 05.07.2022.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
    func toLoginVC()
    func toSignUpVC()
}
