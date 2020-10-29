//
//  SetGameVM.swift
//  SetGame
//
//  Created by Ertugrul Kara on 29/10/2020.
//

import Foundation

class SetGameVM: ObservableObject{
    @Published private var model = SetGame() // TODO: not needed?
    
    init(){
        createGame()
    }
    //MARK:- Intents
    func createGame(){
        model = SetGame()
        drawCards(amount: 12)
    }
    
    func drawCards(amount: Int){
        for _ in 1...amount {
            model.drawCard()
        }
    }
    
    func selectCard(card: Card){
        model.selectCard(card: card)
    }
    //MARK:-  Model access
    var cards: [Card] {
        get {
            model.dealtCards
        }
    }
}
