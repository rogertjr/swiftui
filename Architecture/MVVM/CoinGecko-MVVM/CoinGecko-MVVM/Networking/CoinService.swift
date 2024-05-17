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

extension CoinServiceProtocol {
    func debugLog(_ request: URLRequest, response: HTTPURLResponse? = nil, responseData: Data? = nil, error: Error? = nil) {
        print("\n ====== REQUEST ====== \n")
        defer { print("\n ====== END ====== \n") }
        
        print("URL: \(request.url?.absoluteString ?? "")")
        print("HTTP METHOD: \(request.httpMethod ?? "")")
        
        if let requestHeaders = request.allHTTPHeaderFields,
           let headersData = try? JSONSerialization.data(withJSONObject: requestHeaders, options: .prettyPrinted),
           let headersDataString = String(data: headersData, encoding: .utf8) {
            print("HEADERS: \n\(headersDataString)")
        }
        
        if let requestBodyData = request.httpBody,
           let requestBody = String(data: requestBodyData, encoding: .utf8) {
            print("BODY: \n\(requestBody)")
        }
        
        if let httpResponse = response {
            print("\n ====== RESPONSE ====== \n")
            print("CODE: \(httpResponse.statusCode)")
            
            if let headersData = try? JSONSerialization.data(withJSONObject: httpResponse.allHeaderFields, options: .prettyPrinted),
               let headersDataString = String(data: headersData, encoding: .utf8) {
                print("HEADERS: \n\(headersDataString)")
            }
            
            if let responseBodyData = responseData,
               let responseBody = String(data: responseBodyData, encoding: .utf8) {
                print("BODY: \n\(responseBody)")
            }
        }
        
        if let urlError = error as? URLError {
            print("\n ====== ERROR =======")
            print("CODE: \(urlError.errorCode)")
            print("DESCRIPTION: \(urlError.localizedDescription)\n")
        } else if let error = error as? CoinService.NetworkingError {
            print("\n ====== ERROR =======")
            if case let .invalidStatusCode(int) = error {
                print("CODE: \(int)")
            }
            print("DESCRIPTION: \(error.localizedDescription)\n")
        }
    }
}

struct CoinService: CoinServiceProtocol {
    func fetchAllCoins(_ page: String, perPage: String) async throws -> [Coin] {
        guard let endpointRequest =  CoinApi.fetchCoins(page, perPage: perPage).request else { throw NetworkingError.invalidURL }
        let urlSession = URLSession.shared
        let (data, response) = try await urlSession.data(for: endpointRequest)
                
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            debugLog(endpointRequest, error: NetworkingError.invalidStatusCode(statusCode))
            throw NetworkingError.invalidStatusCode(statusCode)
        }
        
        debugLog(endpointRequest,response: response, responseData: data)
        return try JSONDecoder().decode([Coin].self, from: data)
    }
}
