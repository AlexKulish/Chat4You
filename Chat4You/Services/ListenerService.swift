//
//  ListenerService.swift
//  Chat4You
//
//  Created by Alex Kulish on 13.07.2022.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

class ListenerService {
    
    static let shared = ListenerService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        db.collection("users")
    }
    
    private var currentUserId: String {
        Auth.auth().currentUser!.uid
    }
    
    private init() {}
    
    func usersObserver(users: [MUser], completion: @escaping(Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
        
        var users = users
        
        let usersListener = usersRef.addSnapshotListener { querySnapshot, error in
            guard let querySnapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            querySnapshot.documentChanges.forEach { documentChange in
                guard let mUser = MUser(document: documentChange.document) else {
                    completion(.failure(error!))
                    return
                }
                switch documentChange.type {
                case .added:
                    guard !users.contains(mUser) else { return }
                    guard mUser.id != self.currentUserId else { return }
                    users.append(mUser)
                case .modified:
                    guard let index = users.firstIndex(of: mUser) else { return }
                    users[index] = mUser
                case .removed:
                    guard let index = users.firstIndex(of: mUser) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }
    
}
