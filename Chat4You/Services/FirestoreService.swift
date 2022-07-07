//
//  FirestoreService.swift
//  Chat4You
//
//  Created by Alex Kulish on 06.07.2022.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        db.collection("users")
    }
    
    private init() {}
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        let docRef = usersRef.document(user.uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let mUser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                completion(.success(mUser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
        
    }
    
    func saveProfile(id: String, email: String, userName: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFill(userName: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notFill))
            return
        }
        
        let mUser = MUser(id: id,
                          userName: userName!,
                          email: email,
                          description: description!,
                          sex: sex!,
                          avatarStringURL: "avatarImageString")
        
        usersRef.document(mUser.id).setData(mUser.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(mUser))
            }
        }
    }
    
}
