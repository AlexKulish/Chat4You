//
//  AuthService.swift
//  Chat4You
//
//  Created by Alex Kulish on 28.06.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthService {
    
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email else { return }
        guard let password = password else { return }
        guard let confirmPassword = confirmPassword else { return }
        
        guard Validators.isFill(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFill))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmal))
            return
        }
        
        guard password.lowercased() == confirmPassword.lowercased() else {
            completion(.failure(AuthError.passwordNotMatches))
            return
        }
        
        guard Validators.isSimplePassword(password) else {
            completion(.failure(AuthError.invalidPassword))
            return
        }
        
        auth.createUser(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.notFill))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
        
    }
    
    func loginWithGoogle(viewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { [unowned self] user, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            auth.signIn(with: credential) { result, error in
                guard let result = result else {
                          completion(.failure(error!))
                          return
                      }
                
                completion(.success(result.user))
                
            }
        }
        
    }
    
}


