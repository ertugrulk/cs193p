//
//  ContentView.swift
//  SetGame
//
//  Created by Ertugrul Kara on 28/10/2020.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var vm: SetGameVM
    var body: some View {
        VStack{
            Grid(vm.cards) { card in
                SetGameCardView(card: card)
                    .onTapGesture {
                        withAnimation {
                            self.vm.selectCard(card: card)
                        }
                    }
            }
            HStack{
                Spacer()
            Button("New game") {
                withAnimation {
                    self.vm.startNewGame()
                }
            }
                Spacer()
            Button("Draw 3 cards") {
                self.vm.drawCards(amount: 3)
            }
                Spacer()
            }
        }
    }
}

struct SetGameCardView: View{
    private let padding = CGFloat(10.0)
    private let cornerRadius = CGFloat(20)
    private let edgeLineWidth: CGFloat = 3
    private let cardColor = Color("")
    var card: Card
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size:CGSize) -> some View{
        let contentHeight = (size.height / 3) - (padding * 3)
        Group{
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color("CardColor"))
                .shadow(radius: cornerRadius)
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color("CardBorderColor"))
            VStack{
                Spacer()
                ForEach(0 ..< card.number){ number in
                    switch(card.symbol){
                    case .diamond:
                            Diamond()
                                .frame(width: .infinity, height: contentHeight, alignment: .center)
                        case .oval:
                            Capsule()
                                .frame(width: .infinity, height: contentHeight, alignment: .center)
                        case .squiggle:
                            Circle()
                                .frame(width: .infinity, height: contentHeight, alignment: .center)
                    }
                }
                Spacer()
            }
            .padding(self.padding)
            .foregroundColor(card.color)
        }
        .padding()
        .scaleEffect(card.isSelected ? 1.15 : 1.0)

    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = SetGameVM()
        vm.selectCard(card: vm.cards[0])
        return SetGameView(vm: vm)
            .previewDevice("iPhone 11")
    }
}
