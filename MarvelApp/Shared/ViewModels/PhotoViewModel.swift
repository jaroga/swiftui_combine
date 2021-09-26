//
//  PhotoViewModel.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 26/9/21.
//

import Foundation
import Combine
import SwiftUI

class PhotoViewModel: ObservableObject {
    @Published var photo: Image? // aqui la foto
    
    var suscriptor = Set<AnyCancellable>()
    
    func loadImage(url: String) {
        // Control de cache...
        print(url)
        let urlDownload = URL(string: url)!
        
        URLSession.shared
            .dataTaskPublisher(for: urlDownload)
            .map {
                UIImage(data: $0.data)
            }
            .map{ image -> Image in
                if let img = image {
                    return Image(uiImage: img)
                } else {
                    return Image(systemName: "person.fill")
                }
            }
            .replaceError(with: Image(systemName: "person.fill"))
            .replaceNil(with: Image(systemName: "person.fill"))
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.photo = image
            }
            .store(in: &suscriptor)
    }
}
