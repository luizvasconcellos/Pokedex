//
//  Ability.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import Foundation

struct Ability: Codable {
    let ability: Basic
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct Basic: Codable {
    let name: String
    let url: String
}

struct AbilityDetail: Codable {
    let effectEntries: [EffectEntry]
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case id
        case name
    }
}

struct EffectEntry: Codable {
    let effect: String
    let language: Basic
    let shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect
        case language
        case shortEffect = "short_effect"
    }
}
