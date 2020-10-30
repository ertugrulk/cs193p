//
//  CardShapes.swift
//  SetGame
//
//  Created by Ertugrul Kara on 29/10/2020.
//

import SwiftUI

struct Diamond:Shape{
    func path(in rect: CGRect) -> Path {
        var result = Path()
        result.move(to: CGPoint(x: rect.midX, y: 0))
        result.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        result.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        result.addLine(to: CGPoint(x: 0, y: rect.midY))
        result.addLine(to: CGPoint(x: rect.midX, y: 0))
        return result
    }
}


extension Shape{
    
    func applyShading(shading: Card.shading) -> some View{
        return Group {
            switch shading {
            case .open:
                self.stroke(lineWidth: 3.0).fill()
            case .solid:
                self.fill()
            case .striped:
                self.fill().opacity(0.3)
            }
        }
    }

}
