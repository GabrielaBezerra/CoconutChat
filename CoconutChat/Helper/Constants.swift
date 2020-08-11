//
//  Datasource.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct Constants {
    
    static let primaryUIColor: UIColor = UIColor(red: 120/255, green: 90/255, blue: 62/255, alpha: 1.0)
    static let primaryColor: Color = Color(UIColor(red: 120/255, green: 90/255, blue: 62/255, alpha: 1.0))
    static let secondaryColor: Color = Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0))
    static let tertiaryColor: Color = Color(UIColor(white: 0.8, alpha: 1))
    
    struct Mock {
     
        static let myUser = User(username: "sharkberry", origin: .me)
        static var contactUser = User(username: "john doe", origin: .contact)
        
        static let messages = [
            Message(content: "Hi, I really love your templates and I would like to buy the chat template", user: Mock.myUser),
            Message(content: "Thanks, nice to hear that, can I have your email please?", user: Mock.contactUser),
            Message(content: "😇", user: Mock.myUser),
            Message(content: "Oh actually, I have just purchased the chat template, so please check your email, you might see my order", user: Mock.myUser),
            Message(content: "Great, wait me a sec, let me check", user: Mock.contactUser),
            Message(content: "Sure", user: Mock.myUser)
        ]
        
    }
    
}
