//
//  MessageView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 08/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct MessageView : View {
    
    //var currentMessage: Message
    var checkedMessage: Message
    
    var body: some View {
        
        VStack(alignment: checkedMessage.user.origin == .me ? .trailing : .leading, spacing: 1) {
            
            bubbleMessage(checkedMessage.user.origin)
            title(checkedMessage.user.origin)
        }
    }
    
    
    func title(_ origin: MessageOrigin) -> AnyView {
        switch origin {
        case .me:
            return AnyView (
                HStack {
                    Text(checkedMessage.user.origin == .me ? "Eu" : checkedMessage.user.username)
                        .font(.caption)
                        .lineLimit(1)
                    
                    Spacer().frame(width: 30, height: 0)
                }
            )
            
        case .contact:
            return AnyView (
                HStack {
                    Spacer().frame(width: 30, height: 0)
                    Text(checkedMessage.user.origin == .me ? "Eu" : checkedMessage.user.username)
                        .font(.caption)
                        .lineLimit(1)
                }
            )
            
        }
    }
    
    func bubbleMessage(_ origin: MessageOrigin) -> AnyView {
        switch origin {
        case .me:
            return AnyView(
                HStack {
                    Spacer().frame(width: 80, height: 2)
                    BubbleMessageView(contentMessage: checkedMessage.content, origin: checkedMessage.user.origin)
                }
            )
            
        case .contact:
            return AnyView(
                HStack {
                    BubbleMessageView(contentMessage: checkedMessage.content, origin: checkedMessage.user.origin)
                    Spacer().frame(width: 80, height: 2)
                }
            )
            
        }
    }
    
    
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack(alignment: .center, spacing: 15) {
            MessageView(
                checkedMessage: Message(
                    content: "Hi!",
                    user: User(
                        username: "Sharkberry",
                        origin: .me
                    ),
                    timestamp: 0
                )
            )
            
            MessageView(
                checkedMessage: Message(
                    content: "Hello!",
                    user: User(
                        username: "John Doe",
                        origin: .contact
                    ),
                    timestamp: 1
                )
            )
            
        }.padding(5)
        
    }
}
