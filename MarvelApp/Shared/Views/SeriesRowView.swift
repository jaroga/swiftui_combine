//
//  CharactersRowView.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

struct SeriesRowView: View {
    @ObservedObject private var photoViewModel = PhotoViewModel()

    var serie: Series
    
    var body: some View {
        VStack {
            if let photo = photoViewModel.photo {
                photo
                    .resizable()
                    .frame(width: 300, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(15)
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 300, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .aspectRatio(contentMode: .fill)
            }
            Text("\(serie.title)")
                .font(.title2)
                .bold()
            
            if let description = serie.description {
                Text("\(description)")
                    .font(.caption)
                    .bold()
                    .padding()
            }
            Divider()
                
        }
        .padding(25)
        .onAppear {
            photoViewModel.loadImage(url: serie.thumbnail.path + ".\(serie.thumbnail.thumbnailExtension)")
        }
    }
}

struct SeriesRowView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesRowView(serie: Series(id: 1945, title: "Avengers: The Initiative (2007 - 2010)", description: "Lorem ipsumdolor sit amet", startYear: 2007, endYear: 2010, thumbnail: SeriesThumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/514a2ed3302f5", thumbnailExtension: "jpg")))
    }
}
