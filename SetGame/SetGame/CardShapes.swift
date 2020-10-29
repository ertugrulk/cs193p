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
