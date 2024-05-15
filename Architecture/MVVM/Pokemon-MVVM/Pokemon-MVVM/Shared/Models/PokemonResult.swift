//
//  PokemonResult.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

// MARK: - PokemonResult
struct PokemonResult: Codable {
    let count: Int
    let next, previous: String?
    let results: [Pokemon]
}

extension PokemonResult: Equatable {
    static func == (lhs: PokemonResult, rhs: PokemonResult) -> Bool {
        return lhs.results == rhs.results
    }
}

// MARK: - Pokemon
struct Pokemon: Codable, Identifiable, Equatable {
    let name: String
    let url: String
    
    var id: Int {
        guard let pokemonURL = URL(string: url),
              let id = Int(pokemonURL.lastPathComponent) else { return 0 }
        return id
    }
    
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}
