//
//  Pokemon.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
    let id: Int
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case abilities
        case id
        case moves
        case name
        case sprites
        case stats
        case types
    }
}

struct Move: Codable {
    let move: Basic
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod: Basic
    let versionGroup: Basic

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

class Sprites: Codable {
    let other: Other?

    enum CodingKeys: String, CodingKey {
        case other
    }

    init(other: Other?) {
        self.other = other
    }
}

struct DreamWorld: Codable {
    let frontDefault: String
    let frontFemale: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
}

struct Other: Codable {
    let dreamWorld: DreamWorld
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
