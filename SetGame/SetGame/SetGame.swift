//
//  SetGame.swift
//  SetGame
//
//  Created by Ertugrul Kara on 29/10/2020.
//

import Foundation
import SwiftUI // for color


struct SetGame{
    private var availableCards: [Card] = generateCards()
    var dealtCards: [Card] = []
    
    private static func generateCards() -> [Card] {
        var result = [Card]()
        let colors = [Color.red, .green, .purple]
        for symbol in Card.Symbol.allCases{
            for shading in Card.Shading.allCases {
                for color in colors {
                    for number in 1...3 {
                        let card = Card(symbol: symbol, color: color, number: number, shading: shading)
                        result.append(card)
                    }
                }
            }
        }
        return result.shuffled()
    }
    
    mutating func startGame(){
        availableCards = SetGame.generateCards()
        dealtCards = []
        for _ in 0...11{
            drawCard()
        }
    }
    mutating func drawCard() {
        let card = availableCards.removeFirst()
        dealtCards.append(card) // TODO: Handle empty array
    }
}

struct Card: Identifiable{
    var id = UUID()
    var isFaceUp: Bool = false
    enum Symbol: CaseIterable{
        case Oval, Squiggle, Diamond
    }
    enum Shading: CaseIterable{
        case Solid, Open, Striped
    }
    var symbol: Symbol
    var color: Color
    var number: Int
    var shading: Shading
}
