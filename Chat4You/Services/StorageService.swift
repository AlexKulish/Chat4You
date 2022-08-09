//
//  StorageService.swift
//  Chat4You
//
//  Created by Alex Kulish on 12.07.2022.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class StorageService {
    
    // MARK: - Public properties
    
    static let shared = StorageService()
    
    // MARK: - Private properties
    
    private let storageRef = Storage.storage().reference()
    
    private var avatarsRef: StorageReference {
        storageRef.child("avatars")
    }
    
    private var chatsRef: StorageReference {
        storageRef.child("chats")
    }
    
    private var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Upload avatar
    
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
    
    // MARK: - UploadImageMessage
    
    func uploadImageMessage(image: UIImage, to chat: MChat, completion: @escaping (Result<URL, Error>) -> Void) {
        
        guard let scaledImage = image.scaledToSafeUpUploadSize,
              let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
                
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let chatName = [chat.friendUserName, uid].joined()
        
        chatsRef.child(chatName).child(imageName).putData(imageData, metadata: metadata) { metadata, error in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.chatsRef.child(chatName).child(imageName).downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
    
    // MARK: - DownloadImage
    
    func downloadImage(url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        
        let imageRef = Storage.storage().reference(forURL: url.absoluteString)
        let mb = Int64(1 * 1024 * 1024)
        imageRef.getData(maxSize: mb) { data, error in
            guard let imageData = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(UIImage(data: imageData)))
        }
        
    }
    
}
