//
//  ContentView.swift
//  EmojiArt
//
//  Created by Ertugrul Kara on 30/10/2020.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtVM
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack{
                    ForEach(EmojiArtVM.palette.map { String($0) }, id: \.self) { emoji in
                        Text(emoji)
                            .font(Font.system(size: defaultEmojiSize))
                            .onDrag { return NSItemProvider(object: emoji as NSString) }
                    }
                }
            }
            .padding(.horizontal)
            GeometryReader{ geometry in
                ZStack{
                Rectangle().foregroundColor(.white).overlay(
                    OptionalImage(uiImage: self.document.backgroundImage)
                        .scaleEffect(self.zoomScale)
                )
                .gesture(self.doubleTapToZoom(in: geometry.size))
                    ForEach(self.document.emojis) { emoji in
                        Text(emoji.text)
                            .font(self.font(for: emoji))
                            .position(self.position(for: emoji, in: geometry.size))
                    }
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil){ providers, location in
                    var location = geometry.convert(location, from: .global)
                    location = CGPoint(x: location.x - geometry.size.width/2, y: location.y - geometry.size.height/2)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / zoomScale)
                    return self.drop(providers: providers, at: location)
                }
                .clipped()
            }
        }
    }
    
    @State private var zoomScale: CGFloat = 1.0
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture{
        TapGesture(count: 2)
            .onEnded{
                withAnimation {
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize){
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.zoomScale = min(hZoom, vZoom)
        }
    }
    
    private func font(for emoji: EmojiArt.Emoji) -> Font{
        Font.system(size: emoji.fontSize * zoomScale)
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        var location = emoji.location
        location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
        return CGPoint(x: location.x + size.width/2, y: location.y + size.height/2)
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool{
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            print("dropped \(url)")
            self.document.setBackgroundURL(url)
        }
        if !found{
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
    }
    private let defaultEmojiSize: CGFloat = 40
}

struct OptionalImage: View{
    var uiImage: UIImage?
    
    var body: some View{
        Group{
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
    
}

extension String: Identifiable {
    public var id: String { return self }
}
