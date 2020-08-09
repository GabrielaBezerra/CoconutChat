//
//  ContentMessageView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 08/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentMessageView: View {
    
    var contentMessage: String
    var origin: MessageOrigin
    
    var color: Color
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(origin == .contact ? Color.white : Color.black)
            .background(color)
            .cornerRadius(10)
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentMessageView(contentMessage: "Hi, I am your friend", origin: .contact, color: Color.green)
    }
}
