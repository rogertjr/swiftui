//
//  MVPatternView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import SwiftUI

struct MVPatternView: View {
    @StateObject private var store = Store()
    
    private func populateMovies() async {
        do {
            try await store.fetchMovies()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        List(store.movies) { movie in
            NavigationLink {
                MovieDetailView(movie: movie)
            } label: {
                HStack {
                    AsyncImage(url: movie.poster) { image in
                        image
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 75, height: 75)
                            .redacted(reason: .placeholder)
                            .animatePlaceholder(isLoading: .constant(true))
                    }
                    Text(movie.title)
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Movies")
        .task {
            await populateMovies()
        }
    }
}


#Preview {
    NavigationStack {
        MVPatternView()
            .preferredColorScheme(.dark)
    }
}
