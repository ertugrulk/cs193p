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
    private(set) var dealtCards: [Card] = []
    
    private static func generateCards() -> [Card] {
        var result = [Card]()
        let colors = [Color.red, .green, .purple]
        for symbol in Card.symbol.allCases{
            for shading in Card.shading.allCases {
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
        let card = availableCards.removeFirst() // TODO: Handle empty array
        dealtCards.append(card)
    }
    
    private static func isSetForProperty<T>(_ cond1: T, _ cond2: T, _ cond3: T) -> Bool where T: Equatable {
        let allPropertiesAreTheSame = cond1 == cond2 && cond2 == cond3
        let allPropertiesDiffer = cond1 != cond2 && cond1 != cond3
        return allPropertiesDiffer || allPropertiesAreTheSame
    }
    
    private static func isSet(card1: Card, card2: Card, card3: Card) -> Bool{
        let colorSet = isSetForProperty(card1.color, card2.color, card3.color)
        let numberSet = isSetForProperty(card1.number, card2.number, card3.number)
        let symbolSet = isSetForProperty(card1.symbol, card2.symbol, card3.symbol)
        let shadingSet = isSetForProperty(card1.shading, card2.shading, card3.shading)
        return colorSet && numberSet && symbolSet && shadingSet
    }
    
    mutating func selectCard(card: Card){
        let index = dealtCards.firstIndex(matching: card)!
        dealtCards[index].isSelected = true
    }
}

struct Card: Identifiable{
    var id = UUID()
    var isSelected: Bool = false
    enum symbol: CaseIterable {
        case oval, squiggle, diamond
    }
    enum shading: CaseIterable {
        case solid, open, striped
    }
    var symbol: symbol
    var color: Color
    var number: Int
    var shading: shading
}
