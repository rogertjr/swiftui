//
//  PokemonDetailResult.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation
import UIKit

struct PokemonDetailResult: Codable {
    let abilities: [Ability]
    let height: Int
    let id: Int
    let name: String
    let species: Species
    let sprites: Sprites
    let stats: [Stat?]
    let types: [TypeElement]
    let weight: Int
    
    var pokemonTypeColor: UIColor {
        guard let firstType = self.types.first?.type,
              let typeColor = PokemonTypeColor(rawValue: firstType.name)
            else { return .white }
        return UIColor(hexString: typeColor.hexColor) ?? .white
    }

    enum CodingKeys: String, CodingKey {
        case abilities
        case height
        case id
        case name
        case species, sprites, stats, types, weight
    }
}

extension PokemonDetailResult: Equatable {
    static func == (lhs: PokemonDetailResult, rhs: PokemonDetailResult) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Species
struct Ability: Codable {
    let ability: Abilities

    enum CodingKeys: String, CodingKey {
        case ability
    }
}

// MARK: - Abilities
struct Abilities: Codable {
    let name: String
    let url: String
}

// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backFemale: String?
    let backShiny: String
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String
    let frontShinyFemale: String?
    let animated: Sprites?

    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
        case animated
    }

    init(backDefault: String,
         backFemale: String?,
         backShiny: String,
         backShinyFemale: String?,
         frontDefault: String,
         frontFemale: String?,
         frontShiny: String,
         frontShinyFemale: String?,
         animated: Sprites?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.animated = animated
    }
}

// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeElement
struct TypeElement: Codable, Identifiable {
    let slot: Int
    let type: Species
    
    var id: Int {
        return slot
    }
}
