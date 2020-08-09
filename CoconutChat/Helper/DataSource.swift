//
//  Datasource.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct DataSource {
    static let myUser = User(username: "sharkberry", origin: .me)
    static var contactUser = User(username: "john doe", origin: .contact)
    
    static let myColor: Color = Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0))
    static let contactColor: Color = Color(UIColor(red: 120/255, green: 90/255, blue: 62/255, alpha: 1.0))
    
    static let messages = [
        Message(content: "Hi, I really love your templates and I would like to buy the chat template", user: DataSource.myUser),
        Message(content: "Thanks, nice to hear that, can I have your email please?", user: DataSource.contactUser),
        Message(content: "😇", user: DataSource.myUser),
        Message(content: "Oh actually, I have just purchased the chat template, so please check your email, you might see my order", user: DataSource.myUser),
        Message(content: "Great, wait me a sec, let me check", user: DataSource.contactUser),
        Message(content: "Sure", user: DataSource.myUser)
    ]
}
