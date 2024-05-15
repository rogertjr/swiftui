//
//  PokemonListItemView.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import SwiftUI

struct PokemonListItemView: View {
    // MARK: - Properties
    @EnvironmentObject var pokemonListViewModel: PokemonListViewModel
    let pokemon: Pokemon
    
    // MARK: - Layout
    var body: some View {
        Button {
            Task {
                await pokemonListViewModel.fetchPokemonDetail(pokemon.name)
            }
        } label: {
            VStack(spacing: .zero) {
                AsyncImage(url: pokemon.imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 130)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 130)
                }
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .center) {
                    Text(pokemon.name.capitalized)
                        .foregroundColor(Theme.text)
                        .font(.system(.title3, design: .rounded)).bold()
                    
                    Text(String(format: "#%04d", pokemon.id))
                        .foregroundColor(Theme.text)
                        .font(.system(.subheadline, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
            }
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

// MARK: - PreviewProvider
#Preview {
    var previewPokemon: Pokemon {
        let pokemonResult = try! JSONMapper.decode(MockResultFiles.pokemonResult.rawValue,
                                                   type: PokemonResult.self)
        return pokemonResult.results.first!
    }
    
    return PokemonListItemView(pokemon: previewPokemon)
        .environmentObject(PokemonListViewModel(PokeService()))
        .frame(width: 250)
        .previewLayout(.sizeThatFits)
}
