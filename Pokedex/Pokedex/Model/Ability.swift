//
//  Ability.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import Foundation

struct Ability : Decodable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Abilities: Decodable {
    var all: [Ability]
    var isHidden: Bool
    var slot: Int
    
    enum CodingKeys: String, CodingKey {
        case all = "ability"
        case isHidden = "is_hidden"
        case slot
    }
}


