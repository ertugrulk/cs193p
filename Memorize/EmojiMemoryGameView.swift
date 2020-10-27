//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ertugrul Kara on 27/10/2020.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text(viewModel.theme.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                Spacer()
                    .overlay( HStack{
                        Spacer()
                        Button("New Game") {
                            self.viewModel.startNewGame()
                        }
                        .padding(.trailing)
                    })
            }
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                }
                .padding(self.cardPadding)
            }
            .padding()
            .foregroundColor(viewModel.theme.color)
            Text("Score: \(viewModel.score)")
        }
    }
    
    // MARK: - Drawing Constants
    
    private let cardPadding: CGFloat = 5
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if(card.isFaceUp || !card.isMatched) {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockWise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content)
            }.cardify(isFaceUp: card.isFaceUp)
            .font(Font.system(size: fontSize(for: size)))
        }
    }
    
    // MARK: - Drawing Constants
    

    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
