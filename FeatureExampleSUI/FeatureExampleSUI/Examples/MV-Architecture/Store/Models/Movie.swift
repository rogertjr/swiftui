//
//  Movie.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

struct Movie: Decodable, Identifiable, Hashable {
    
    let imdbId: String
    let title: String
    let poster: URL
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case title = "Title"
        case poster = "Poster"
    }
}

extension Movie {
    static var preview: Movie {
        Movie(imdbId: "tt4853102", title: "Batman: The Killing Joke", poster: URL(string: "https://m.media-amazon.com/images/M/MV5BMTdjZTliODYtNWExMi00NjQ1LWIzN2MtN2Q5NTg5NTk3NzliL2ltYWdlXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg")!)
    }
}

struct MovieDetail: Decodable, Identifiable {
    
    let imdbId: String
    let title: String
    let poster: URL
    let director: String
    
    var id: String {
        imdbId
    }
    
    private enum CodingKeys: String, CodingKey {
        case imdbId = "imdbID"
        case title = "Title"
        case poster = "Poster"
        case director = "Director"
    }
    
}

struct MovieResponse: Decodable {
    let search: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct NewsArticleResponse: Decodable {
    let articles: [NewsArticle]
}

struct NewsArticle: Decodable, Identifiable {
    let title: String
    let description: String
    let id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
}
