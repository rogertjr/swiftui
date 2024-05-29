//
//  IMDBService.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
}

class IMDBService {
    func loadMovies() async throws -> [Movie] {
        print("\n ====== REQUEST ====== \n")
        defer { print("\n ====== END ====== \n") }
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa") else {
            print("\n ====== ERROR =======")
            print("DESCRIPTION: \(NetworkError.badUrl.localizedDescription)\n")
            throw NetworkError.badUrl
        }
        
        print("URL: \(url.absoluteString)")
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data)
        
        if let requestBody = String(data: data, encoding: .utf8) {
            print("\n ====== RESPONSE ====== \n")
            print("BODY: \n\(requestBody)")
        }
        
        return movieResponse?.search ?? []
    }
    
    func loadMovieBy(_ movieId: String) async throws -> MovieDetail {
        print("\n ====== REQUEST ====== \n")
        defer { print("\n ====== END ====== \n") }
        
        guard let url = URL(string: "http://www.omdbapi.com/?i=\(movieId)&apikey=564727fa") else {
            print("\n ====== ERROR =======")
            print("DESCRIPTION: \(NetworkError.badUrl.localizedDescription)\n")
            throw NetworkError.badUrl
        }
        
        print("URL: \(url.absoluteString)")
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
            print("\n ====== ERROR =======")
            print("DESCRIPTION: \(NetworkError.invalidRequest.localizedDescription)\n")
            throw NetworkError.invalidRequest
        }
        
        if let requestBody = String(data: data, encoding: .utf8) {
            print("\n ====== RESPONSE ====== \n")
            print("BODY: \n\(requestBody)")
        }
        
        return movieDetail
    }
    
    func loadNewsArticleBy(_ keyword: String) async throws -> [NewsArticle] {
        print("\n ====== REQUEST ====== \n")
        defer { print("\n ====== END ====== \n") }
        
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=\(keyword)&apiKey=0cf790498275413a9247f8b94b3843fd&pageSize=10") else {
            print("\n ====== ERROR =======")
            print("DESCRIPTION: \(NetworkError.badUrl.localizedDescription)\n")
            throw NetworkError.badUrl
        }
        
        print("URL: \(url.absoluteString)")
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let newsArticleResponse = try? JSONDecoder().decode(NewsArticleResponse.self, from: data) else {
            print("\n ====== ERROR =======")
            print("DESCRIPTION: \(NetworkError.invalidRequest.localizedDescription)\n")
            throw NetworkError.invalidRequest
        }
        
        if let requestBody = String(data: data, encoding: .utf8) {
            print("\n ====== RESPONSE ====== \n")
            print("BODY: \n\(requestBody)")
        }
        
        return newsArticleResponse.articles
    }
}
