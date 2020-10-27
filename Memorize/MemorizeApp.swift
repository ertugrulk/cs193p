//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
