//
//  SeriesViewModel.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 26/9/21.
//

import Foundation
import Combine

class SeriesViewModel: ObservableObject {
    @Published var series: MarvelSeries?
    @Published var status = Status.none
    
    var character: Character?
    
    var suscriptors = Set<AnyCancellable>()
    
    init(testing: Bool = false) {
        if (testing) {
            //getCharactersTesting()
            
        } else {
            getSeriesCharacters()
        }
    }
    
    func getSeriesCharacters() {
        self.status = Status.loading
        
        URLSession.shared
            .dataTaskPublisher(for: BaseNetwork().getSeriesCharacters(idCharacter: character.id))
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                // el JSON
//                let m = try? JSONDecoder().decode(Marvel.self, from: $0.data)
//                print(String(decoding: $0.data, as: UTF8.self))
//
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
                self.series = data
            }
            .store(in: &suscriptors)

    }
    
    // Testing y Diseño
//    func getCharactersTesting() {
//        self.status = Status.loading
//
//        let character1 = Character(id: 1011334, name: "3-D Man", resultDescription: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334")
//        let character2 = Character(id: 1017100, name: "A-Bomb (HAS)", resultDescription: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction!", m, thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16", thumbnailExtension: .jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100")
//        let character3 = Character(id: 1009144, name: "A.I.M.", resultDescription: "AIM is a terrorist organization bent on destroying the world.", , thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/6/20/52602f21f29ec", thumbnailExtension: .jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1009144")
//        self.characters = [character1, character2, character3]
//
//        self.status = Status.loaded
//    }
}

