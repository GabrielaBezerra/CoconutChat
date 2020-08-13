//
//  Message.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 08/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation

struct Message: Hashable {
    var content: String
    var user: User
    let timestamp: Double
}
