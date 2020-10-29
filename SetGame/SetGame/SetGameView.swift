//
//  ContentView.swift
//  SetGame
//
//  Created by Ertugrul Kara on 28/10/2020.
//

import SwiftUI

struct SetGameView: View {
    var vm: SetGameVM = SetGameVM()
    var body: some View {
        VStack{
            Grid(vm.cards) { card in
                SetGameCardView(card: card)
            }
        }
    }
}

struct SetGameCardView: View{
    var card: Card
    var body: some View{
        VStack{
            let symbol = String(describing: card.symbol)
            ForEach(0 ..< card.number){ number in
                Text("\(symbol)") // TODO: Add remaining card contents
            }
        }
        .foregroundColor(card.color)
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
            .previewDevice("iPhone 11")
    }
}
