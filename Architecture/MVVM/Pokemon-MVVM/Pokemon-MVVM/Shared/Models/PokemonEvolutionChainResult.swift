//
//  PokemonEvolutionChainResult.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

// MARK: - PokemonEvolutionChainResult
struct PokemonEvolutionChainResult: Codable {
    let id: Int
    let chain: Chain

    enum CodingKeys: String, CodingKey {
        case chain, id
    }
}

extension PokemonEvolutionChainResult: Equatable {
    static func == (lhs: PokemonEvolutionChainResult, rhs: PokemonEvolutionChainResult) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Chain
struct Chain: Codable {
    let evolvesTo: [Chain]
    let species: Species

    enum CodingKeys: String, CodingKey {
        case evolvesTo = "evolves_to"
        case species
    }
}


// MARK: - Custom Class
struct CustomEvolutionChain: Equatable {
    let id: String
    let name: String
    let speciesURL: String
    
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}
