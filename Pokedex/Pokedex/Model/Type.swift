//
//  Type.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 25/04/21.
//

import Foundation

struct Type: Decodable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Types: Decodable {
    var slot: Int
    var type: Type
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
}
