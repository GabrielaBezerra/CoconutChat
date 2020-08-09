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
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 0) {
                
                List {
                    ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
                        MessageView(checkedMessage: msg).flip()
                    }
                }.flip()
                
                HStack {
                    TextField("Mensagem...", text: $typingMessage)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: CGFloat(30))
                    Button(action: sendMessage) {
                        Image(systemName: "message.circle.fill")
                            .font(.system(size: 32))
                    }.foregroundColor(DataSource.contactColor)
                }.frame(minHeight: CGFloat(50)).padding()
                
            }.navigationBarTitle(Text(DataSource.contactUser.username.localizedCapitalized), displayMode: .inline)
                
                .padding(.bottom, keyboard.currentHeight)
                .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading: .bottom)
            
        }.onTapGesture {
            self.endEditing(true)
        }
    }
    
    func sendMessage() {
        chatHelper.sendMessage(Message(content: typingMessage, user: DataSource.myUser))
        typingMessage = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
