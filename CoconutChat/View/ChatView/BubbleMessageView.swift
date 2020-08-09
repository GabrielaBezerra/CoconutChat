//
//  BubbleMessageView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct BubbleMessageView: View {
    
    var contentMessage: String
    var origin: MessageOrigin
    
    var body: some View {
        bubbleView(origin)
    }
    
    func bubbleView(_ origin: MessageOrigin) -> AnyView {
        switch origin {
        case .me:
            return AnyView(
                HStack(alignment: .center, spacing: -7) {
                    Spacer()
                    
                    ContentMessageView(
                        contentMessage: contentMessage,
                        origin: origin,
                        color: DataSource.myColor
                    )
                    
                    TailView(
                        direction: .rightToLeft,
                        color: DataSource.myColor
                    )
                }
            )
        case .contact:
            return AnyView(
                HStack(alignment: .center, spacing: -7) {
                    TailView(
                        direction: .leftToRight,
                        color: DataSource.contactColor
                    )
                    
                    ContentMessageView(
                        contentMessage: contentMessage,
                        origin: origin,
                        color: DataSource.contactColor
                    )
                    
                    Spacer()
                }
            )
        }
    }
}


struct BubbleMessageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .center, spacing: 5) {
            BubbleMessageView(contentMessage: "Hello", origin: .me)
            BubbleMessageView(contentMessage: "Hi!", origin: .contact)
        }
    }
}
