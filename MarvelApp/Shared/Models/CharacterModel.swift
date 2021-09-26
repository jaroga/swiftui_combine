//
//  CharacterModel.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import Foundation

enum Status {
    case none, loading, loaded, register, error(error: String)
}
    
// MARK: - Marvel
struct Marvel: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

// MARK: - Character
struct Character: Codable, Identifiable {
    let id: Int
    let name, description: String
    //let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
}

// MARK: - Comics
//struct Comics: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [ComicsItem]
//    let returned: Int
//}

// MARK: - ComicsItem
//struct ComicsItem: Codable {
//    let resourceURI: String
//    let name: String
//}

// MARK: - Stories
//struct Stories: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [StoriesItem]
//    let returned: Int
//}

// MARK: - StoriesItem
//struct StoriesItem: Codable {
//    let resourceURI: String
//    let name: String
//    let type: ItemType
//}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - URLElement
//struct URLElement: Codable {
//    let type: URLType
//    let url: String
//}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
