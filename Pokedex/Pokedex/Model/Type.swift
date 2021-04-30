//
//  Type.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 25/04/21.
//

import Foundation

struct TypeElement: Codable {
    let slot: Int
    let type: Basic
}

struct Type: Codable {
    let id: Int
    let name: String
    let pokemon: [PokemonType]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pokemon
    }
}

struct PokemonType: Codable {
    let pokemon: Basic
    let slot: Int
}
