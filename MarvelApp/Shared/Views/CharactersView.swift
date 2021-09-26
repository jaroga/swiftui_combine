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
        NavigationView {
            List {
                if let characters = characterviewModel.characters?.data.results {
                    ForEach(characters) { data in
                        NavigationLink(
                            destination: SeriesView(character: data),
                            label: {
                                CharactersRowView(character: data)
                            })
                    }
                    
                }
            }
        }
    }
}

//struct CharactersView_Previews: PreviewProvider {
//    static var previews: some View {
//        CharactersView(characterviewModel: CharactersViewModel(testing: true))
//    }
//}
