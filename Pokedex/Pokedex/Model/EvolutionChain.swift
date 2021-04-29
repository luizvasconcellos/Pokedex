//
//  EvolutionChain.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 28/04/21.
//

import Foundation

struct EvolutionChain: Codable {
    let chain: Chain
    let id: Int

    enum CodingKeys: String, CodingKey {
        case chain
        case id
    }
}

struct Chain: Codable {
    let evolvesTo: [Chain]
    let isBaby: Bool
    let species: Basic

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}
