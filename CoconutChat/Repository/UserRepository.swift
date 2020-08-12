//
//  UserRepository.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 10/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

class UserRepository: ObservableObject {
    
    static let singleton: UserRepository = UserRepository()
    
    @Published var connectedUser: User?
    
    func connect(username: String) {
        self.connectedUser = User(username: username, origin: .me, status: .online)
    }
}
