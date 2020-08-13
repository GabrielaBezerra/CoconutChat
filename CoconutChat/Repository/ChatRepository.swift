//
//  ChatHelper.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import Combine

class ChatRepository: ObservableObject {
    
    static let singleton: ChatRepository = ChatRepository()

    var didChange = PassthroughSubject<Void, Never>()    
    @Published var realTimeMessages: [Message] = []
    
    func sendMessage(content: String, to contact: User, timestamp: Double) {
        DispatchQueue.main.async {
            let chatMessage = Message(content: content, user: UserRepository.singleton.connectedUser!, timestamp: timestamp)
            self.realTimeMessages.append(chatMessage)
            self.didChange.send(())
        }
    }
    
    func receiveMessage(_ chatMessage: Message) {
        DispatchQueue.main.async {
            self.realTimeMessages.append(chatMessage)
            self.didChange.send(())
        }
    }
    
}
