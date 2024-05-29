//
//  Store.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

@MainActor
class Store: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var newsArticles: [NewsArticle] = []
    @Published var movieDetail: MovieDetail?
    
    func fetchMovies() async throws {
       movies = try await IMDBService().loadMovies()
    }
    
    func fetchMovieById(_ movieId: String) async throws {
        movieDetail = try await IMDBService().loadMovieBy(movieId)
    }
    
    func fetchArticlesByKeyword(_ keyword: String) async throws {
        newsArticles = try await IMDBService().loadNewsArticleBy(keyword)
    }
}
