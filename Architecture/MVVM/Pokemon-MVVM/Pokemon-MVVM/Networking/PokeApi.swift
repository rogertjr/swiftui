//
//  PokeApi.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

enum PokeApi {
    case fetchPokemons(_ limit: String, offset: String)
    case fetchPokemonDetail(_ name: String)
    case fetchPokemonsSpecies(_ id: String)
    case fetchPokemonEvolutionChain(_ id: String)
}

extension PokeApi {
    static let baseUrl = "https://pokeapi.co"
    static let apiVersion = "/api/v2"
    
    var path: String {
        switch self {
        case .fetchPokemons:
            return String(format: "%@/pokemon", PokeApi.apiVersion)
        case .fetchPokemonDetail(let name):
            return String(format: "%@/pokemon/%@", PokeApi.apiVersion, name)
        case .fetchPokemonsSpecies(let id):
            return String(format: "%@/pokemon-species/%@", PokeApi.apiVersion, id)
        case .fetchPokemonEvolutionChain(let id):
            return String(format: "%@/evolution-chain/%@", PokeApi.apiVersion, id)
        }
    }
    
    var method: String {
        switch self {
        case .fetchPokemons,
                .fetchPokemonDetail,
                .fetchPokemonsSpecies,
                .fetchPokemonEvolutionChain:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .fetchPokemons(limit, offset):
            return [
                URLQueryItem(name: "limit", value: limit),
                URLQueryItem(name: "offset", value: offset)
            ]
        default:
            return []
        }
    }
    
    var request: URLRequest {
        var urlComponents = URLComponents(string: PokeApi.baseUrl)!
        urlComponents.scheme = "https"
        urlComponents.path = path
        
        if case .fetchPokemons = self {
            urlComponents.queryItems = queryItems
        }
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
