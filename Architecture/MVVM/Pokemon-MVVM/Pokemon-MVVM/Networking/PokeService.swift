//
//  PokeService.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation

protocol PokeServiceProtocol {
    func fetchPokemons(_ limit: String, offset: String) async throws -> PokemonResult
    func fetchPokemonDetail(_ name: String) async throws -> PokemonDetailResult
    func fetchPokemonsSpecies(_ id: String) async throws -> PokemonSpeciesResult
    func fetchPokemonEvolutionChain(_ id: String) async throws -> PokemonEvolutionChainResult
}

struct PokeService: PokeServiceProtocol {
    /// Fetches a list of pokemons with pagination using limit and offset
    func fetchPokemons(_ limit: String, offset: String) async throws -> PokemonResult {
        let urlSession = URLSession.shared
        let endpoint = PokeApi.fetchPokemons(limit, offset: offset)
        let (data, response) = try await urlSession.data(for: endpoint.request)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let pokemonData = try JSONDecoder().decode(PokemonResult.self, from: data)
        return pokemonData
    }
    
    func fetchPokemonDetail(_ name: String) async throws -> PokemonDetailResult {
        let urlSession = URLSession.shared
        let endpoint = PokeApi.fetchPokemonDetail(name)
        let (data, response) = try await urlSession.data(for: endpoint.request)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let pokemonData = try JSONDecoder().decode(PokemonDetailResult.self, from: data)
        return pokemonData
    }
    
    func fetchPokemonsSpecies(_ id: String) async throws -> PokemonSpeciesResult {
        let urlSession = URLSession.shared
        let endpoint = PokeApi.fetchPokemonsSpecies(id)
        let (data, response) = try await urlSession.data(for: endpoint.request)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let pokemonData = try JSONDecoder().decode(PokemonSpeciesResult.self, from: data)
        return pokemonData
    }
    
    func fetchPokemonEvolutionChain(_ id: String) async throws -> PokemonEvolutionChainResult {
        let urlSession = URLSession.shared
        let endpoint = PokeApi.fetchPokemonEvolutionChain(id)
        let (data, response) = try await urlSession.data(for: endpoint.request)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        let pokemonData = try JSONDecoder().decode(PokemonEvolutionChainResult.self, from: data)
        return pokemonData
    }
}
