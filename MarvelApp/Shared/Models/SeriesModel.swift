//
//  SeriesModel.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 26/9/21.
//

import Foundation
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

// MARK: - Welcome
struct MarvelSeries: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: SeriesDataClass
}

// MARK: - DataClass
struct SeriesDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Series]
}

// MARK: - Result
struct Series: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let resourceURI: String
    let urls: [URLElement]
    let startYear, endYear: Int
    let rating, type: String
    let thumbnail: SeriesThumbnail
    let creators: Creators
    let characters: SeriesCharacters
    let stories: Stories
    let comics, events: SeriesCharacters
    let next, previous: Next?
}

// MARK: - Characters
struct SeriesCharacters: Codable {
    let available: Int
    let collectionURI: String
    let items: [Next]
    let returned: Int
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int
    let collectionURI: String
    let items: [CreatorsItem]
    let returned: Int
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String
    let name, role: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct SeriesThumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
