//
//  NewsApi.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

let NEWS_API_BASE_URL = "https://api.lil.software"
let NEWS_PATH = "/news"

enum ResultState {
    case idle
    case loading
    case success(content: [Article])
    case failure(error: Error)
}

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path:String { get }
}

enum NewsAPI {
    case getNews
}

extension NewsAPI: APIBuilder {
    var urlRequest: URLRequest {
        URLRequest(url: baseUrl.appendingPathComponent(path))
    }
    
    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: NEWS_API_BASE_URL)!
        }
    }
    
    var path: String {
        NEWS_PATH
    }
}
