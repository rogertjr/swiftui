//
//  PokemonListViewModel.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import Foundation
import Combine

final class PokemonListViewModel: ObservableObject {
    // MARK: - Properties
    private let service: PokeServiceProtocol
    
    @Published private(set) var error: PokeService.NetworkingError?
    @Published private(set) var state: ViewState = .idle
    @Published var hasError = false
    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var pokemonDetail: PokemonDetailResult?
    @Published var searchedPokemon: String = ""
    @Published var searchedPokemons: [Pokemon]?
    
    var subscriptions = Set<AnyCancellable>()
    
    private let limit: Int = 20
    private(set) var page: Int = 0
    private(set) var totalOfPokemons: Int = 0
    private var offSet: Int { page * limit }
    
    var isLoading: Bool { return state == .isLoading }
    
    // MARK: - Init
    init(_ service: PokeServiceProtocol) {
        self.service = service
        
        $searchedPokemon
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                if !term.isEmpty {
                    self?.filterPokemonsBySearch()
                } else {
                    self?.searchedPokemons = nil
                }
            }.store(in: &subscriptions)
    }
    
    // MARK: - Helpers
    private func resetData() {
        if state == .finishedLoading {
            state = .idle
            pokemons = []
            page = 0
        }
    }
    
    func hasReachedEnd(of pokemon: Pokemon) -> Bool {
        pokemons.last?.id == pokemon.id
    }
    
    private func filterPokemonsBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.pokemons
                .lazy
                .filter { pokemon in
                    return pokemon.name.lowercased().contains(self.searchedPokemon.lowercased())
                }
            DispatchQueue.main.async {
                self.searchedPokemons = results.compactMap({ pokemon in
                    return pokemon
                })
            }
        }
    }
    
    // MARK: - Networking
    @MainActor
    func fetchPokemons() async {
        guard !isLoading else { return }
        resetData()
        
        state = .isLoading
        defer { state = .finishedLoading }
        
        do {
            let pokemonResponse = try await service.fetchPokemons(String(limit), offset: String(offSet))
            pokemons += pokemonResponse.results
            totalOfPokemons = pokemonResponse.count
            hasError = false
        } catch {
            state = .error("Failed to fetch pokemons")
            hasError = true
            if let networkingError = error as? PokeService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfPokemons() async {
        guard offSet < totalOfPokemons, !isLoading else { return }
        state = .isLoading

        defer { state = .finishedLoading }

        page += 1
        do {
            let pokemonResponse = try await service.fetchPokemons(String(limit), offset: String(offSet))
            pokemons += pokemonResponse.results
            hasError = false
        } catch {
            state = .error("Failed to fetch pokemons")
            hasError = true
            if let networkingError = error as? PokeService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
    
    @MainActor
    func fetchPokemonDetail(_ name: String) async {
        guard !name.isEmpty else {
            hasError = true
            state = .error("No pokemons was selected")
            return
        }
        
        defer { state = .finishedLoading }
        
        state = .isLoading
        do {
            let pokemonDetailResult = try await service.fetchPokemonDetail(name)
            pokemonDetail = pokemonDetailResult
            hasError = false
        } catch {
            state = .error("Failed to fetch pokemon detail")
            hasError = true
            if let networkingError = error as? PokeService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
}
