//
//  CoinService.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import Foundation

protocol CoinServiceProtocol {
    func fetchAllCoins(_ page: String, perPage: String) async throws -> [Coin]
}

struct CoinService: CoinServiceProtocol {
    func fetchAllCoins(_ page: String, perPage: String) async throws -> [Coin] {
        guard let endpointRequest =  CoinApi.fetchCoins(page, perPage: perPage).request else { throw NetworkingError.invalidURL }
        let urlSession = URLSession.shared
        let (data, response) = try await urlSession.data(for: endpointRequest)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        return try JSONDecoder().decode([Coin].self, from: data)
    }
}
