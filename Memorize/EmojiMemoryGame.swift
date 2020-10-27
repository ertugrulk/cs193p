//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["😎", "👻", "🎃"]	
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex]}
    }
    
    // (User) Intent
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
