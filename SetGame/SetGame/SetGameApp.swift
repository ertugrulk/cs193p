//
//  SetGameApp.swift
//  SetGame
//
//  Created by Ertugrul Kara on 28/10/2020.
//

import SwiftUI

@main
struct SetGameApp: App {
    var body: some Scene {
        WindowGroup {
            let vm = SetGameVM()
            SetGameView(vm: vm)
        }
    }
}
