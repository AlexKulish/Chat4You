//
//  WaitingChatsDelegate.swift
//  Chat4You
//
//  Created by Alex Kulish on 20.07.2022.
//

import Foundation

protocol WaitingChatsDelegate: AnyObject {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
