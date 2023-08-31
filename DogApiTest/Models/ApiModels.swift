//
//  ApiModels.swift
//  DogApiTest
//
//  Created by Александр Молчан on 31.08.23.
//

import Foundation

struct BreedModel: Decodable {
    var name: String
    var id: String
    var wikiLink: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case wikiLink = "wikipedia_url"
    }
}

struct BreedImageModel: Decodable {
    var id: String?
    var url: String?
}

