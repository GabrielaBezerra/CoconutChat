//
//  ContactHelper.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 10/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import Combine

class ContactRepository: ObservableObject {
    
    var didAddContact = PassthroughSubject<Void, Never>()
    
    static let singleton: ContactRepository = ContactRepository()
    
    static let mock: ContactRepository = {
    
        let helper = ContactRepository()
        helper.contacts = [
            User(username: "bruxa71", origin: .contact),
            User(username: "seu madruga", origin: .contact, status: .online),
            User(username: "chaves", origin: .contact, status: .online)
        ]
        return helper
        
    }()
    
    @Published var contacts: [User] = []
    @Published var alertInputText: String?
    
    func addContact() {
        
        guard let contactUsername = alertInputText, contactUsername.replacingOccurrences(of: " ", with: "") != "" else { return }
        
        guard let myUsername = UserRepository.singleton.connectedUser?.username, myUsername.replacingOccurrences(of: " ", with: "") != "" else { return }
        
        guard contacts.filter({ $0.username == contactUsername }).isEmpty else {
            print("Contact already added")
            return
        }
        
        alertInputText = ""

        print("> Adicionando contato: \(contactUsername), meu username: \(myUsername)")
        
        //Cria fila de mensagens que eu mandar e assina
        MiddlewareManager.singleton.addQueue(named: "\(myUsername):\(contactUsername)")
        
        //Cria fila de mensagens que eu receber e assina
        MiddlewareManager.singleton.addQueue(named: "\(contactUsername):\(myUsername)", subscribe: true, onSubscribe: { msg, timestamp in
            print(contactUsername, msg)
            ChatRepository.singleton.receiveMessage(
                Message(
                    content: msg,
                    user: User(username: "\(contactUsername)", origin: .contact),
                    timestamp: timestamp
                )
            )
        })
        
        //Faz requisicao pra assinar topico (adicionar contato)
        MiddlewareManager.singleton.connectTo(contact: "\(contactUsername)", subscribeMe: true)
        
        DispatchQueue.main.async {
            self.contacts.append(User(username: "\(contactUsername)", origin: .contact))
            self.didAddContact.send(())
        }
        
    }
}
