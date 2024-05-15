//
//  PokemonListView.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import SwiftUI

struct PokemonListView: View {
    // MARK: - Properties
    var animation: Namespace.ID
    @StateObject var viewModel = PokemonListViewModel(PokeService())
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    // MARK: - Layout
    var body: some View {
        ZStack {
            background
            
            VStack(alignment: .leading) {
                Text("Pokedex")
                    .font(.title.bold())
                    .foregroundColor(Theme.text)
                    .padding([.leading, .top])
                
                SearchBar(placeholder: "Filter by name",
                          text: $viewModel.searchedPokemon)
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom)
                    .disabled(viewModel.pokemons.isEmpty)
                
                if !viewModel.pokemons.isEmpty {
                    ScrollView {
                        gridView
                            .padding(.horizontal)
                    }
                } else {
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("Pokedex list is empty")
                            .font(.subheadline.bold())
                            .foregroundColor(Theme.text)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.fetchPokemons()
        }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
            Button("Retry", role: .cancel) {
                Task {
                    await viewModel.fetchPokemons()
                }
            }
            Button("Cancel", role: .destructive) { }
        }
        .overlay(content: {
            ZStack {
                if case .isLoading = viewModel.state {
                    ProgressView("Loading...")
                        .foregroundColor(Theme.text)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background {
                            Theme.background
                                .ignoresSafeArea()
                        }
                }
            }
        })
    }
}

// MARK: - Subviews
extension PokemonListView {
    var background: some View {
        Theme.background
            .ignoresSafeArea()
    }
}

// MARK: - ViewBuilders
extension PokemonListView {
    @ViewBuilder
    var gridView: some View {
        if let searchedPokemons = viewModel.searchedPokemons,
           searchedPokemons.count > 0 {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(searchedPokemons, id: \.id) { pokemon in
                    PokemonListItemView(pokemon: pokemon)
                        .environmentObject(viewModel)
                }
            }
        } else {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemons, id: \.id) { pokemon in
                    PokemonListItemView(pokemon: pokemon)
                        .environmentObject(viewModel)
                        .task {
                            if viewModel.hasReachedEnd(of: pokemon) && !viewModel.isLoading {
                                await viewModel.fetchNextSetOfPokemons()
                            }
                        }
                }
            }
        }
    }
}

// MARK: - PreviewProvider
#Preview {
    @Namespace var animation
    return PokemonListView(animation: animation)
        .environmentObject(PokemonListViewModel(PokeService()))
}
