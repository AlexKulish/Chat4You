//
//  StorageService.swift
//  Chat4You
//
//  Created by Alex Kulish on 12.07.2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        storageRef.child("avatars")
    }
    
    private var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }
    
    private init() {}
    
    func upload(avatar: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let scaledImage = avatar.scaledToSafeUpUploadSize,
              let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        guard let currentUserId = currentUserId else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        avatarsRef.child(currentUserId).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            
            self.avatarsRef.child(currentUserId).downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
        
    }
    
    
}
