//
//  Pokemon.swift
//  Pokedex
//
//  Created by Luiz Vasconcellos on 26/04/21.
//

import Foundation

// MARK: - Welcome
//struct NewPokemon: Codable {
//    let abilities: [Ability]
//    let baseExperience: Int
//    let forms: [Species]
////    let gameIndices: [GameIndex]
//    let height: Int
//    let heldItems: [JSONAny]
//    let id: Int
//    let isDefault: Bool
//    let locationAreaEncounters: String
//    let moves: [Move]
//    let name: String
//    let order: Int
//    let pastTypes: [JSONAny]
//    let species: Species
//    let sprites: Sprites
//    let stats: [Stat]
//    let types: [TypeElement]
//    let weight: Int
//
//    enum CodingKeys: String, CodingKey {
//        case abilities
//        case baseExperience = "base_experience"
//        case forms
////        case gameIndices = "game_indices"
//        case height
//        case heldItems = "held_items"
//        case id
//        case isDefault = "is_default"
//        case locationAreaEncounters = "location_area_encounters"
//        case moves, name, order
//        case pastTypes = "past_types"
//        case species, sprites, stats, types, weight
//    }
//}

// MARK: - GameIndex
//struct GameIndex: Codable {
//    let gameIndex: Int
//    let version: Species
//
//    enum CodingKeys: String, CodingKey {
//        case gameIndex = "game_index"
//        case version
//    }
//}



// MARK: - GenerationV
//struct GenerationV: Codable {
//    let blackWhite: Sprites
//
//    enum CodingKeys: String, CodingKey {
//        case blackWhite = "black-white"
//    }
//}

// MARK: - GenerationIv
//struct GenerationIv: Codable {
//    let diamondPearl, heartgoldSoulsilver, platinum: Sprites
//
//    enum CodingKeys: String, CodingKey {
//        case diamondPearl = "diamond-pearl"
//        case heartgoldSoulsilver = "heartgold-soulsilver"
//        case platinum
//    }
//}

// MARK: - Versions
//struct Versions: Codable {
//    let generationI: GenerationI
//    let generationIi: GenerationIi
//    let generationIii: GenerationIii
//    let generationIv: GenerationIv
//    let generationV: GenerationV
//    let generationVi: [String: GenerationVi]
//    let generationVii: GenerationVii
//    let generationViii: GenerationViii
//
//    enum CodingKeys: String, CodingKey {
//        case generationI = "generation-i"
//        case generationIi = "generation-ii"
//        case generationIii = "generation-iii"
//        case generationIv = "generation-iv"
//        case generationV = "generation-v"
//        case generationVi = "generation-vi"
//        case generationVii = "generation-vii"
//        case generationViii = "generation-viii"
//    }
//}



// MARK: - GenerationI
//struct GenerationI: Codable {
//    let redBlue, yellow: RedBlue
//
//    enum CodingKeys: String, CodingKey {
//        case redBlue = "red-blue"
//        case yellow
//    }
//}

// MARK: - RedBlue
//struct RedBlue: Codable {
//    let backDefault, backGray, frontDefault, frontGray: String
//
//    enum CodingKeys: String, CodingKey {
//        case backDefault = "back_default"
//        case backGray = "back_gray"
//        case frontDefault = "front_default"
//        case frontGray = "front_gray"
//    }
//}

// MARK: - GenerationIi
//struct GenerationIi: Codable {
//    let crystal, gold, silver: Crystal
//}

// MARK: - Crystal
//struct Crystal: Codable {
//    let backDefault, backShiny, frontDefault, frontShiny: String
//
//    enum CodingKeys: String, CodingKey {
//        case backDefault = "back_default"
//        case backShiny = "back_shiny"
//        case frontDefault = "front_default"
//        case frontShiny = "front_shiny"
//    }
//}

// MARK: - GenerationIii
//struct GenerationIii: Codable {
//    let emerald: Emerald
//    let fireredLeafgreen, rubySapphire: Crystal
//
//    enum CodingKeys: String, CodingKey {
//        case emerald
//        case fireredLeafgreen = "firered-leafgreen"
//        case rubySapphire = "ruby-sapphire"
//    }
//}

// MARK: - Emerald
//struct Emerald: Codable {
//    let frontDefault, frontShiny: String
//
//    enum CodingKeys: String, CodingKey {
//        case frontDefault = "front_default"
//        case frontShiny = "front_shiny"
//    }
//}

// MARK: - GenerationVi
//struct GenerationVi: Codable {
//    let frontDefault: String
//    let frontFemale: JSONNull?
//    let frontShiny: String
//    let frontShinyFemale: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case frontDefault = "front_default"
//        case frontFemale = "front_female"
//        case frontShiny = "front_shiny"
//        case frontShinyFemale = "front_shiny_female"
//    }
//}

// MARK: - GenerationVii
//struct GenerationVii: Codable {
//    let icons: DreamWorld
//    let ultraSunUltraMoon: GenerationVi
//
//    enum CodingKeys: String, CodingKey {
//        case icons
//        case ultraSunUltraMoon = "ultra-sun-ultra-moon"
//    }
//}



// MARK: - Stat
//struct Stat: Codable {
//    let baseStat, effort: Int
//    let stat: Species
//
//    enum CodingKeys: String, CodingKey {
//        case baseStat = "base_stat"
//        case effort, stat
//    }
//}

// MARK: - TypeElement
//struct TypeElement: Codable {
//    let slot: Int
//    let type: Tuple
//}

// MARK: - Encode/decode helpers
/*
class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
*/





//================
//================
//================
//================
//================
//================


/*
struct Poke: Decodable {
    var name: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}

struct Pokemon: Codable {
    let abilities: [Ability]
    let id: Int
    let isDefault: Bool
    let moves: [Move]
    let name: String
    let sprites: Sprites
    let stats: [Stat]
    let types: [TypeElement]

    enum CodingKeys: String, CodingKey {
        case abilities
        case id
        case isDefault = "is_default"
        case moves
        case name
        case sprites
        case stats
        case types
    }
}

// MARK: - Move
struct Move: Codable {
    let move: Tuple
    let versionGroupDetails: [VersionGroupDetail]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

// MARK: - VersionGroupDetail
struct VersionGroupDetail: Codable {
    let levelLearnedAt: Int
    let moveLearnMethod, versionGroup: Tuple

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
        case versionGroup = "version_group"
    }
}

// MARK: - Sprites
class Sprites: Codable {
//    let backDefault: String
//    let backFemale: JSONNull?
//    let backShiny: String
//    let backShinyFemale: JSONNull?
//    let frontDefault: String
//    let frontFemale: JSONNull?
//    let frontShiny: String
//    let frontShinyFemale: JSONNull?
    let other: Other?
//    let versions: Versions?
//    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
//        case backDefault = "back_default"
//        case backFemale = "back_female"
//        case backShiny = "back_shiny"
//        case backShinyFemale = "back_shiny_female"
//        case frontDefault = "front_default"
//        case frontFemale = "front_female"
//        case frontShiny = "front_shiny"
//        case frontShinyFemale = "front_shiny_female"
        case other
//        case versions, animated
    }

    init(other: Other?) {
//    init(backDefault: String, backFemale: JSONNull?, backShiny: String, backShinyFemale: JSONNull?, frontDefault: String, frontFemale: JSONNull?, frontShiny: String, frontShinyFemale: JSONNull?, other: Other?, versions: Versions?, animated: Sprites?) {
//        self.backDefault = backDefault
//        self.backFemale = backFemale
//        self.backShiny = backShiny
//        self.backShinyFemale = backShinyFemale
//        self.frontDefault = frontDefault
//        self.frontFemale = frontFemale
//        self.frontShiny = frontShiny
//        self.frontShinyFemale = frontShinyFemale
        self.other = other
//        self.versions = versions
//        self.animated = animated
    }
}

struct DreamWorld: Codable {
    let frontDefault: String
//    let frontFemale: JSONNull?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
//        case frontFemale = "front_female"
    }
}

// MARK: - GenerationViii
//struct GenerationViii: Codable {
//    let icons: DreamWorld
//}

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






























/*
struct Pokemon {
    var id: Int?
    var name: String?
    var order: Int?
    var height: Int?
    var weight: Int?
    var baseExperience: Int?
    var abilities: Abilities?
    var isDefault: Bool?
//    var stats: [Stat]
//    var types: [Types]
    var defaultImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case order
        case height
        case weight
        case abilities = "ability"
        case baseExperience = "base_experience"
        case isDefault = "is_default"
        case stats = "stats"
//        case defaultImageUrl
        case types
        case defaultImageUrl = "official-artwork"
    }
    
    enum DefaultImageKeys: String, CodingKey {
        case defaultImageUrl = "front_default"
    }
    
//    enum GiftKeys: CodingKey {
//      case toy
//    }
    
//    enum TypeKeys: String, CodingKey {
//        case slot
//        case type
//    }
}

extension Pokemon: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        order = try values.decode(Int.self, forKey: .order)
        height = try values.decode(Int.self, forKey: .height)
        weight = try values.decode(Int.self, forKey: .weight)
        baseExperience = try values.decode(Int.self, forKey: .baseExperience)
        isDefault = try values.decode(Bool.self, forKey: .isDefault)
//        types = try values.decode(Types.self, forKey: .types)
        
        let defaultImage = try values.nestedContainer(keyedBy: DefaultImageKeys.self, forKey: .defaultImageUrl)
        defaultImageUrl = try defaultImage.decode(String.self, forKey: .defaultImageUrl)
        
//        let statInfo = try values.nestedContainer(keyedBy: StatKeys.self, forKey: .statInfo)
//        name = try statInfo.decode(String.self, forKey: .name)
//        url = try statInfo.decode(String.self, forKey: .url)
        
//        let types = try values.nestedContainer(keyedBy: TypeKeys.self, forKey: .types)
//        slot = try types.decode(String.self, forKey: .types)
//        types = try types.decode(Type.self, forKey: .types)
    }
}

*/
*/
