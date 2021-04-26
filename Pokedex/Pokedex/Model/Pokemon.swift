//
//  Pokemon.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import Foundation

struct Pokemon: Decodable {
    var id: Int?
    var name: String?
//    var url: String
    var order: Int?
    var height: Int?
    var weight: Int?
    var baseExperience: Int?
    var abilities: Abilities?
    var isDefault: Bool?
//    var stats: [Stats]
//    var types: [Types]
//    var imageURL: ArtworkImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
//        case url
        case order
        case height
        case weight
        case abilities = "ability"
        case baseExperience = "base_experience"
        case isDefault = "is_default"
//        case stats
//        case types
//        case imageURL = "official-artwork"
    }
}

struct Poke: Decodable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

//struct ArtworkImage: Decodable {
//    var imageURL: String
//    
//    enum CodingKeys: String, CodingKey {
//        case imageURL = "front_default"
//    }
//}
