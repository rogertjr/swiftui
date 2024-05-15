//
//  PokemonSpeciesResult.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

struct PokemonSpeciesResult: Codable {
    let eggGroups: [EggGroup]?
    let flavorTextEntries: [FlavorText]?
    let evolutionChain: EvolutionChain?
    let genera: [Genus]?
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case evolutionChain = "evolution_chain"
        case eggGroups = "egg_groups"
        case genera
    }
}

extension PokemonSpeciesResult: Equatable {
    static func == (lhs: PokemonSpeciesResult, rhs: PokemonSpeciesResult) -> Bool {
        return lhs.evolutionChain?.id == rhs.evolutionChain?.id
    }
}

// MARK: - EggGroup
struct EggGroup: Codable {
    let name: String
    let url: String
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String?
    var id: String? {
        guard let urlString = url,
              let url = URL(string: urlString) else { return nil }
        return url.lastPathComponent
    }
}

// MARK: - FlavorText
struct FlavorText: Codable {
    let flavorText: String
    let language: Language
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

// MARK: - Genus
struct Genus: Codable {
    let genus: String
    let language: Language
}

// MARK: - Language
struct Language: Codable {
    let name: String
    let url: String
}
