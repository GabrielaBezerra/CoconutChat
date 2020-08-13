//
//  ChatView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 08/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @State var typingMessage: String = ""
    @ObservedObject var chatRepository: ChatRepository = ChatRepository.singleton
    @ObservedObject private var keyboard = KeyboardResponder()
    
    private var contact: User
    
    init(contact: User) {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
        UINavigationBar.appearance().tintColor = Constants.primaryUIColor
        UITextField.appearance().tintColor = Constants.primaryUIColor
        
        self.contact = contact
    }
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 0) {
            
            if chatRepository.realTimeMessages.isEmpty {
                Spacer()
                Text("Diga Olá\n:D")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .opacity(0.25)
                    .multilineTextAlignment(.center)
                Spacer()
            } else {
                List {
                    ForEach(chatRepository.realTimeMessages.sorted { $0.timestamp < $1.timestamp }.reversed(), id: \.self) { msg in
                        MessageView(checkedMessage: msg).flip()
                    }
                }
                .flip()
                .onTapGesture {
                    self.endEditing(true)
                }
            }
            
            HStack {
                TextField("Mensagem...", text: $typingMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))
                    .foregroundColor(Constants.primaryColor)
                Button(action: sendMessage) {
                    Image(systemName: "message.circle.fill")
                        .font(.system(size: 32))
                }
                .foregroundColor(Constants.primaryColor)
            }
            .frame(minHeight: CGFloat(50)).padding()
            
        }
        .navigationBarTitle(Text(contact.username), displayMode: .inline)
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
        
    }
    
    func sendMessage() {
        guard typingMessage.replacingOccurrences(of: " ", with: "") != "" else { return }
        //chatHelper.sendMessage(content: typingMessage, to: contact)
        typingMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contact: Constants.Mock.contactUser)
    }
}
