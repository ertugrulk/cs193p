//
//  EmojiArtVM.swift
//  EmojiArt
//
//  Created by Ertugrul Kara on 30/10/2020.
//

import SwiftUI
class EmojiArtVM: ObservableObject {
    static let palette: String = "👵🕸✓✅🚲😊"
    private var emojiArt: EmojiArt = EmojiArt()
    {
        willSet{
            objectWillChange.send()
        }
        didSet{
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtVM.untitled)
        }
    }
    
    @Published private(set) var backgroundImage: UIImage?
    
    init(){
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtVM.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    private static let untitled = "EmojiArtDocument.untitled"
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis}
    
    // MARK: - Intents
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat){
        emojiArt.addEmoji(emoji,x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize){
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat){
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    func setBackgroundURL(_ URL: URL?){
        emojiArt.backgroundURL = URL
        fetchBackgroundImageData()
    }
    
    private func fetchBackgroundImageData(){
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url){
                    DispatchQueue.main.async {
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
            
        }
    }
}

extension EmojiArt.Emoji  {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(self.x), y: CGFloat(self.y))}
}
