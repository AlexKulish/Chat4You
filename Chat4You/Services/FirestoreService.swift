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
    
    private var waitingChatsRef: CollectionReference {
        db.collection(["users", currentUser.id, "waitingChats"].joined(separator: "/"))
    }
    
    private var currentUser: MUser!
    
    private init() {}
    
    // Получаем юзера
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        let docRef = usersRef.document(user.uid)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                guard let mUser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = mUser
                completion(.success(mUser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
        
    }
    
    // Сохраняем профиль юзера
    func saveProfile(id: String, email: String, userName: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFill(userName: userName, description: description, sex: sex) else {
            completion(.failure(UserError.notFill))
            return
        }
        
        guard avatarImage != UIImage(named: "avatar") else {
            completion(.failure(UserError.photoNotExist))
            return
        }
        
        StorageService.shared.upload(avatar: avatarImage!) { result in
            switch result {
            case .success(let avatarUrl):
                let mUser = MUser(id: id,
                                  userName: userName ?? "",
                                  email: email,
                                  description: description ?? "",
                                  sex: sex ?? "",
                                  avatarStringURL: avatarUrl.absoluteString)
                self.usersRef.document(mUser.id).setData(mUser.representation) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(mUser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // Создаем ожидающий чат
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {

        let waitingChatsReference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageReference = waitingChatsReference.document(currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: message)
        
        let chat = MChat(friendUserName: currentUser.userName,
                         friendUserImageStringURL: currentUser.avatarStringURL,
                         lastMessage: message.content,
                         friendId: currentUser.id)

        waitingChatsReference.document(currentUser.id).setData(chat.representation) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageReference.addDocument(data: message.representation) { error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
    
    // Удаляем ожидающий чат
    func deleteWaitingChat(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        waitingChatsRef.document(chat.friendId).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            self.deleteWaitingChatMessages(chat: chat, completion: completion)
        }
    }
    
    // Получаем все сообщения
    private func getWaitingChatMessages(chat: MChat, completion: @escaping (Result<[MMessage], Error>) -> Void) {
        
        var messages = [MMessage]()
        
        let messageReference = waitingChatsRef.document(chat.friendId).collection("messages")
        
        messageReference.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let querySnapshot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            
            querySnapshot.documents.forEach { queryDocumentSnapshot in
                guard let message = MMessage(document: queryDocumentSnapshot) else { return }
                messages.append(message)
            }
            completion(.success(messages))
        }
    }
    
    // Удаляем сообщения
    private func deleteWaitingChatMessages(chat: MChat, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let messageReference = waitingChatsRef.document(chat.friendId).collection("messages")
        
        getWaitingChatMessages(chat: chat) { result in
            switch result {
            case .success(let messages):
                for message in messages {
                    guard let messageId = message.id else { return }
                    let messageRef = messageReference.document(messageId)
                    messageRef.delete { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        completion(.success(Void()))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
