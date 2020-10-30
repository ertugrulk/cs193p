//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Ertugrul Kara on 30/10/2020.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtVM())
        }
    }
}
