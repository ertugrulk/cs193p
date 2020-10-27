//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import Foundation
import SwiftUI
import Swift

let EmojiThemes = [EmojiTheme(name: "Halloween", showAllCards: false, emojis: ["🎃", "👻", "🕷", "🕸"], color: .orange),
    EmojiTheme(name: "Countries", showAllCards: true, emojis: ["🇹🇩", "🇵🇱", "🇷🇸", "🇹🇷"], color: .red)]


class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    var theme: EmojiTheme

    init(){
        let randomThemeIdx = Int.random(in: 0..<EmojiThemes.count)
        self.theme = EmojiThemes[randomThemeIdx]
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    }
    
    private static func createMemoryGame(theme: EmojiTheme) -> MemoryGame<String>{
        var availableEmojis = theme.emojis.shuffled()
        var emojis: [String]
        if theme.showAllCards {
            let cardAmount = Int.random(in: 2..<availableEmojis.count) 
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
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in emojis[pairIndex]}
    }
    
    // MARK: - Intents
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func startNewGame(){
        let randomThemeIdx = Int.random(in: 0..<EmojiThemes.count)
        self.theme = EmojiThemes[randomThemeIdx]
        self.model = EmojiMemoryGame.createMemoryGame(theme: self.theme)
    } // TODO: Combine with init
    
    // MARK: - Model Access
    
    var score: Int {
        get {
            model.score
        }
    }
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
}
