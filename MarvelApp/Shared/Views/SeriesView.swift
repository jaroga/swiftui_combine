//
//  SeriesView.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

struct SeriesView: View {
    @StateObject private var seriesViewModel: SeriesViewModel = SeriesViewModel()
    var character: Character
    
    init(idCharacter: Character) {
        self.character = idCharacter
    }
    
    var body: some View {
        switch seriesViewModel.status {
        case Status.none:
            let _ = seriesViewModel.getSeriesCharacters(idCharacter: character.id)
        case Status.loading:
            VStack {
                LottieView(name: "loading", loopMode: .loop)
                    .frame(width: 250, height: 250)
                    .padding()
                Text("Cargando")
            }
        case Status.loaded:
            ScrollView(.vertical) {
                VStack {
                    if let dataSeries = seriesViewModel.series {
                        ForEach(dataSeries) { serie in
                            SeriesRowView(serie: serie)
                        }
                    }
                }
                .navigationBarTitle(Text("\(character.name)"), displayMode: .large)
            }
        case Status.error(error: let errorString):
            Text("Error: \(errorString)")
        }
    }
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesView(idCharacter: SeriesViewModel().getSeriesTesting())
    }
}
