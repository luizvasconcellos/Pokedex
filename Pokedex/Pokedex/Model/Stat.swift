//
//  Stat.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 25/04/21.
//

import Foundation

struct Stat : Decodable{
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Stats : Decodable{
    var base: String
    var effort: String
    var stat: Stat
    
    
    enum CodingKeys: String, CodingKey {
        case base = "base_stat"
        case effort
        case stat
    }
}
