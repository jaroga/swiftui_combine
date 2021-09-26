//
//  BaseNetwork.swift
//  MarvelApp (iOS)
//
//  Created by José Ángel Rodríguez on 25/9/21.
//

import Foundation

let server = "https://gateway.marvel.com"
let apikey = "4e338cd77404f215d37f0e171c3b634e"
let secretkey = "4837da3624b3b3c4b13f8aec737ae6f9fb33d497"

struct HTTPMethods {
    static let get = "GET"
    
    static let contentType = "application/json"
}

enum endpoints: String {
    case charactersList = "/v1/public/characters"
    //case seriesList = "/api/data/developers"
}

struct BaseNetwork {
    
    // Listado de Personajes
    func getCharacters() -> URLRequest {
        let ts = Int(Date().timeIntervalSince1970)
        let hash = Encription().getMd5Hash(ts: ts, apikey: apikey, secretkey: secretkey)
        
        let urlCad: String = "\(server)\(endpoints.charactersList.rawValue)?ts=\(ts)&apikey=\(apikey)&hash=\(hash)"
        //Creamos el request
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!) // Aqui se debería de desempaquetar
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-type")
        
        return request
    }
    
    // Listado de Personajes
    func getSeriesCharacters(idCharacter: Int) -> URLRequest {
        let ts = Int(Date().timeIntervalSince1970)
        let hash = Encription().getMd5Hash(ts: ts, apikey: apikey, secretkey: secretkey)
        
        let urlCad: String = "\(server)\(endpoints.charactersList.rawValue)/\(idCharacter)/series?ts=\(ts)&apikey=\(apikey)&hash=\(hash)"
        //Creamos el request
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!) // Aqui se debería de desempaquetar
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-type")
        
        return request
    }
}
