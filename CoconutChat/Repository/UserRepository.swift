//
//  UserRepository.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 10/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct UserRepository {
    private static var currentUser: User?
    
    static var connectedUser: User { currentUser! }
    
    static func connect() {
        self.currentUser = Constants.Mock.myUser
    }
}
