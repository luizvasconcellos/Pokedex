//
//  Stat.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 25/04/21.
//

import Foundation

struct Stat: Codable {
    let baseStat: Int
    let effort: Int
    let stat: Basic

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}
