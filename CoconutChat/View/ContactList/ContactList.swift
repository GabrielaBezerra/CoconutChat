//
//  ContactList.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct ContactList: View {
    
    @EnvironmentObject var contactHelper: ContactRepository
    
    @State var showLoginAlert: Bool
    @State var showAddContactAlert: Bool
    
    @State var loginInputText: String?
    
    init() {
        UINavigationBar.appearance().tintColor = Constants.primaryUIColor
        self._showLoginAlert = State(initialValue: UserRepository.singleton.connectedUser == nil)
        self._showAddContactAlert = State(initialValue: false)
    }
    
    var body: some View {
        
        NavigationView {
            
            contactList()
                
                .navigationBarTitle("🥥 Lista de Contatos")
                .navigationBarItems(trailing: addContactButton())
            
        }
        .textFieldAlert(isPresented: $showLoginAlert) { () -> TextFieldAlert in
            TextFieldAlert(title: "Olá", message: "Insira o seu nome de usuário", buttonText: "Conectar", text: self.$loginInputText, action: {
                if let username = self.loginInputText {
                    UserRepository.singleton.connect(username: username)
                }
            })
        }
        .textFieldAlert(isPresented: $showAddContactAlert) { () -> TextFieldAlert in
            TextFieldAlert(title: "Novo Contato", message: "Insira o nome de usuário do contato que você quer adicionar", buttonText: "Adicionar", text: self.$contactHelper.alertInputText, action: self.contactHelper.addContact)
        }
        
    }
    
    let statusSort: (User, User) -> Bool = {
        a, _ in
        a.status == .online
    }
    
    func addContactButton() -> some View {
        Button(action: {
            self.showAddContactAlert = true
        }) {
            Image(systemName: "plus")
                .foregroundColor(Constants.primaryColor)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .imageScale(.large)
                .accessibility(label: Text("Add Contact"))
                .padding()
        }
    }
    
    func contactList() -> AnyView {
        if contactHelper.contacts.isEmpty {
            return AnyView(
                VStack(alignment: .center, spacing: 0) {
                    Spacer()
                    Text("Olá \(UserRepository.singleton.connectedUser?.username ?? "")\nVocê ainda não adicionou\n nenhum contato").font(.system(size: 20, weight: .medium, design: .rounded)).opacity(0.25)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            )
        } else {
            return AnyView(
                ScrollView {
                    Spacer().frame(width: 100, height: 12)
                    
                    VStack(alignment: .center, spacing: 1) {
                        ForEach(contactHelper.contacts.sorted(by: statusSort), id: \.username) { contact in
                            
                            NavigationLink(
                                destination: ChatView(contact: contact)
                            ) {
                                ContactView(contact: contact)
                            }
                        }
                    }
                }
                .padding(.trailing, -25)
                .padding(.leading, 12)
                .padding(.top, 1)
                .padding(.bottom, 0)
                .background(Color(UIColor.systemGroupedBackground))
                .foregroundColor(Constants.primaryColor)
                
            )
        }
    }
    
}

struct ContactListPopulated_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environmentObject(ContactRepository.mock)
    }
}

struct ContactListEmpty_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environmentObject(ContactRepository())
    }
}
