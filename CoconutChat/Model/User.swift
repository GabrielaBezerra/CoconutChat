//
//  User.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 08/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct User: Hashable {
    var username: String
    var origin: MessageOrigin
    var status: UserStatus = .offline
}
