//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame(theme: EmojiTheme(name: "Halloween", amountOfCardsToBeShown: 3, emojis: ["🎃", "👻", "🕷", "🕸"], color: .orange))
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
