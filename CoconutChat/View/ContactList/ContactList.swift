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
    
    @EnvironmentObject var contactHelper: ContactHelper
    
    @State var showAddContactAlert: Bool
    
    init() {
        UINavigationBar.appearance().tintColor = Constants.primaryUIColor
        self._showAddContactAlert = State(initialValue: false)
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                contactList()
            }
            .navigationBarTitle("🥥 Lista de Contatos")
            .navigationBarItems(trailing: addContactButton())
            
        }.textFieldAlert(isPresented: $showAddContactAlert) { () -> TextFieldAlert in
            TextFieldAlert(title: "Novo Contato", message: "Insira o nome de usuário do contato que você quer adicionar", text: self.$contactHelper.alertInputText, action: self.contactHelper.addContact)
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
                    Text("Você ainda não adicionou\n nenhum contato").font(.system(size: 20, weight: .medium, design: .rounded)).opacity(0.25)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            )
        } else {
            return AnyView(
                ScrollView {
                    Spacer().frame(width: 100, height: 12)
                    ForEach(contactHelper.contacts.sorted(by: statusSort), id: \.username) { contact in
                        
                        NavigationLink(
                            destination: ChatView(contact: contact)
                        ) {
                            ContactView(contact: contact)
                        }
                    }
                }
                .padding(.trailing, -25)
                .padding(.leading, 12)
                .padding(.top, 1)
                .background(Color(UIColor.systemGroupedBackground))
                .foregroundColor(Constants.primaryColor)
                
            )
        }
    }
    
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environmentObject(ContactHelper())
    }
}
