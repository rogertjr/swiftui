//
//  MovieDetailView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import SwiftUI

struct MovieDetailView: View {
    // MARK: - Properties
    @StateObject private var store = Store()
    let movie: Movie
    
    // MARK: - UI Elements
    var body: some View {
        List {
            if let movieDetail = store.movieDetail {
                AsyncImage(url: movieDetail.poster)
                
                Text(movieDetail.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                if !store.newsArticles.isEmpty {
                    ForEach(store.newsArticles) { article in
                        Text(article.title)
                            .foregroundStyle(.primary)
                    }
                } else {
                    Text("No articles found.")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.primary)
                }
            }
        }
        .navigationTitle("Articles")
        .task {
            do {
                try await store.fetchMovieById(movie.id)
                try await store.fetchArticlesByKeyword(movie.title)
            } catch {
                print(error)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MovieDetailView(movie: Movie.preview)
        .preferredColorScheme(.dark)
}
