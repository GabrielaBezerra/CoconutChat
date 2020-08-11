//
//  ChatHelper.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import Combine

class ChatHelper: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var realTimeMessages: [Message] = []
    
    func sendMessage(content: String, to contact: User) {
        let chatMessage = Message(content: content, user: UserRepository.connectedUser)
        realTimeMessages.append(chatMessage)
        didChange.send(())
    }
    
    func receiveMessage(_ chatMessage: Message) {
        realTimeMessages.append(chatMessage)
        didChange.send(())
    }
}
