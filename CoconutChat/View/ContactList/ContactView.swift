//
//  ContactView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct ContactView: View {
    
    var contact: User
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(Constants.primaryColor)
                .opacity(contact.status == .online ? 1 : 0.2)
            Text(contact.username)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Constants.primaryColor)
            Spacer()
        }
        .padding()
        .background(Color(UIColor.white))
        .cornerRadius(50)
    }
}

struct ContactViewOnline_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
            ContactView(contact: User(username: "CidcleyIFCE", origin: .contact, status: .online))
            .padding()
        }
    }
}

struct ContactViewOffline_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
            ContactView(contact: User(username: "FernandoParenteIFCE", origin: .contact, status: .offline))
                .padding()
        }
    }
}
