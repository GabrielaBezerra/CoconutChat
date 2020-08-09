//
//  TailView.swift
//  CoconutChat
//
//  Created by Gabriela Bezerra on 09/08/20.
//  Copyright © 2020 Gabriela Bezerra. All rights reserved.
//

import Foundation
import SwiftUI

struct TailShape: Shape {
    
    let direction: LayoutDirection
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        switch direction {
        
        case .leftToRight:
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: 10, y: 25))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: 20, y: 15))
            break
            
        case .rightToLeft:
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: 10, y: 15))
            
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: 10, y: 25))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            
            break
        
        @unknown default:
            break
        }
        
        return path
    }
}

struct TailView: View {
    
    var direction: LayoutDirection
    var color: Color
    
    var body: some View {
        TailShape(direction: direction)
            .fill(color)
            .frame(width: 30, height: 20)
    }
}


struct TailViewLeftToRight_Previews: PreviewProvider {
    static var previews: some View {
        TailView(direction: .leftToRight, color: Color.green)
    }
}

struct TailViewRightToLeft_Previews: PreviewProvider {
    static var previews: some View {
        TailView(direction: .rightToLeft, color: Color.gray)
    }
}
