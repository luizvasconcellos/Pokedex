//
//  Pokedex.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 24/04/21.
//

import Foundation

struct Pokedex: Decodable {
    var count: Int
    var nextPageUrl: String
    var previousPageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextPageUrl = "next"
        case previousPageUrl = "previous"
    }
}
