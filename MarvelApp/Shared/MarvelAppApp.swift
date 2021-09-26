//
//  MarvelAppApp.swift
//  Shared
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

@main
struct MarvelAppApp: App {
    var body: some Scene {
        WindowGroup {
            CharactersView(characterviewModel: CharactersViewModel())
        }
    }
}
