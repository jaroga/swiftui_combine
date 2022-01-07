//
//  SeriesViewModel.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 26/9/21.
//

import Foundation
import Combine

class SeriesViewModel: ObservableObject {
    @Published var series: [Series]?
    @Published var status = Status.none
    
    var suscriptors = Set<AnyCancellable>()
        
    func getSeriesCharacters(idCharacter: Int) {
        self.status = Status.loading        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSeriesCharacters(idCharacter: idCharacter))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: MarvelSeries.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure:
                    self.status = Status.error(error: "Error al buscar los personajes")
                case .finished:
                    self.status = Status.loaded
                }
            } receiveValue: { data in
                self.series = data.data.results
            }
            .store(in: &suscriptors)
    }
    
    // Testing y Diseño
    func getSeriesTesting() -> Character {
        return Character(id: 1011334, name: "3-D Man", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334")
        /*
        self.status = Status.loading
         
        let serie1 = Series(id: 1945, title: "Avengers: The Initiative (2007 - 2010)", description: "", startYear: 2007, endYear: 2010, thumbnail: SeriesThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/514a2ed3302f5", thumbnailExtension: "jpg"))
        let serie2 = Series(id: 2005, title: "Deadpool (1997 - 2002)", description: "Wade Wilson: Heartless Merc With a Mouth or...hero? Laugh, cry and applaud at full volume for the mind-bending adventures of Deadpool, exploring the psyche and crazed adventures of Marvel's most unstable personality!", startYear: 1997, endYear: 2002, thumbnail: SeriesThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/7/03/5130f646465e3", thumbnailExtension: "jpg"))
        let serie3 = Series(id: 2045, title: "Marvel Premiere (1972 - 1981)", description: "", startYear: 1972, endYear: 1981, thumbnail: SeriesThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/4/40/5a98437953d4e", thumbnailExtension: "jpg"))
        self.series = [serie1, serie2, serie3]

        self.status = Status.loaded
         */
    }
}

