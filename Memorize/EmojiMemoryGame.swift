//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import Foundation
import SwiftUI
import Swift

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    var theme: EmojiTheme
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    init(theme: EmojiTheme) {
        self.theme = theme
        var availableEmojis = theme.emojis.shuffled()
        var emojis: [String]
        if let cardAmount = theme.amountOfCardsToBeShown {
            emojis = [String]()
            for _ in 0..<cardAmount {
                let randomEmojiIdx = Int.random(in: 0..<availableEmojis.count)
                let randomEmoji = availableEmojis[randomEmojiIdx]
                emojis.append(randomEmoji)
                availableEmojis.remove(at: randomEmojiIdx)
            }
        } else {
            emojis = availableEmojis
        }
        model = MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex]}
    }
    
    // (User) Intent
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
