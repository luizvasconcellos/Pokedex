//
//  Species.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 28/04/21.
//

import Foundation

struct Species: Codable {
    let evolutionChainUrl: BasicUrl?
    let id: Int?
    let name: String?
    let varieties: [Variety]?

    enum CodingKeys: String, CodingKey {
        case evolutionChainUrl = "evolution_chain"
        case id
        case name
        case varieties
    }
}

struct BasicUrl: Codable {
    let url: String
}

struct Variety: Codable {
    let isDefault: Bool
    let pokemon: Basic

    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
