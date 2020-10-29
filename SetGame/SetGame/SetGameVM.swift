//
//  SetGameVM.swift
//  SetGame
//
//  Created by Ertugrul Kara on 29/10/2020.
//

import Foundation

class SetGameVM{
    @Published private var model = SetGame() // TODO: not needed?
    
    init(){
        createGame()
    }
    //MARK:- Intents
    func createGame(){
        model = SetGame()
        for _ in 1...12 {
            drawCard()
        }
    }
    
    func drawCard(){
        model.drawCard()
    }
    //MARK:-  Model access
    var cards: [Card] {
        get {
            model.dealtCards
        }
    }
}
