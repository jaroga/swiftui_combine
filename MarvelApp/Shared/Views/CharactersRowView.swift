//
//  CharactersRowView.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import SwiftUI

struct CharactersRowView: View {
    @ObservedObject private var photoViewModel = PhotoViewModel()

    var character: Character
    
    var body: some View {
        HStack {
            if let photo = photoViewModel.photo {
                photo
                    .resizable()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .bottom], 10)
                
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10)
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .bottom], 10)
            }
            Text("\(character.name)")
                .bold()
                .padding()
        }
        .onAppear {
            photoViewModel.loadImage(url: character.thumbnail.path + ".\(character.thumbnail.thumbnailExtension.rawValue)")
        }
    }
}

struct CharactersRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersRowView(character: Character(id: 1011334, name: "3-D Man", description: "", thumbnail: Thumbnail(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784", thumbnailExtension: .jpg), resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334"))
    }
}
