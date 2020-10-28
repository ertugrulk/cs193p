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
                            withAnimation(.easeInOut){
                                self.viewModel.startNewGame()
                            }
                        }
                        .padding(.trailing)
                    })
            }
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration:0.75)){
                        self.viewModel.choose(card: card)
                    }
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
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if(card.isFaceUp || !card.isMatched) {
            ZStack {
                Group{
                if card.isConsumingBonusTime {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360-90), clockWise: true)

                        .onAppear{
                            self.startBonusTimeAnimation()
                        }
                } else {
                    Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining * 360-90), clockWise: true)
                }
                }
                .padding(5)
                .opacity(0.4)
                Text(card.content)
                    .transition(.scale)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .font(Font.system(size: fontSize(for: size)))
            .transition(AnyTransition.scale)
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
