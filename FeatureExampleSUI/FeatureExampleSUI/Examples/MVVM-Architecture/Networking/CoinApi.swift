//
//  CoinApi.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import Foundation

enum CoinApi {
    case fetchCoins(_ page: String, perPage: String)
}

extension CoinApi {
    static let baseUrl = "https://api.coingecko.com"
    static let apiVersion = "/api/v3"
    
    var path: String {
        switch self {
        case .fetchCoins:
            return String(format: "%@/coins/markets", CoinApi.apiVersion)
        }
    }
    
    var method: String {
        switch self {
        case .fetchCoins:
            return "GET"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case let .fetchCoins(page, perPage):
            return [
                URLQueryItem(name: "vs_currency", value: "usd"),
                URLQueryItem(name: "order", value: "market_cap_desc"),
                URLQueryItem(name: "per_page", value: perPage),
                URLQueryItem(name: "page", value: page),
                URLQueryItem(name: "sparkline", value: "true"),
                URLQueryItem(name: "price_change_percentage", value: "24h"),
            ]
        }
    }
    
    var request: URLRequest? {
        guard var urlComponents = URLComponents(string: CoinApi.baseUrl) else { return nil }
        urlComponents.scheme = "https"
        urlComponents.path = path
        
        if case .fetchCoins = self {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
