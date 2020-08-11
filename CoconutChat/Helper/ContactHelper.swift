//
//  ContactHelper.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 10/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import Combine

class ContactHelper: ObservableObject {
    
    var didAddContact = PassthroughSubject<Void, Never>()
    
    @Published var contacts: [User] = []
    @Published var alertInputText: String?
    
    func addContact() {
        guard let username = alertInputText?.localizedCapitalized, username.replacingOccurrences(of: " ", with: "") != "" else { return }
        alertInputText = ""

        print("Adicionando contato: \(username)")

        //Faz requisicao pra assinar topico (adicionar contato)

        //no retorno bem sucedido:
        self.contacts.append(
            User(username: username, origin: .contact)
        )

        //no retorno mal sucedido:
            //mostrar aviso de erro
        
        didAddContact.send(())
    }
}
