//
//  ContentView.swift
//  Shared
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

struct CharactersView: View {
    @StateObject var characterviewModel: CharactersViewModel
    
    var body: some View {
        switch characterviewModel.status {
        case Status.none:
            Text("Inicializando")
        case Status.loading:
            VStack {
                LottieView(name: "loading", loopMode: .loop)
                    .frame(width: 250, height: 250)
                    .padding()
                Text("Cargando")
            }
        case Status.loaded:
            NavigationView {
                List {
                    if let characters = characterviewModel.characters {
                        ForEach(characters) { data in
                            NavigationLink(
                                destination: SeriesView(idCharacter: data),
                                label: {
                                    CharactersRowView(character: data)
                                })
                        }
                    }
                }
                .navigationBarTitle(Text("Personajes"), displayMode: .large)
            }
        case Status.error(error: let errorString):
            Text("Error: \(errorString)")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView(characterviewModel: CharactersViewModel(testing: true))
    }
}
