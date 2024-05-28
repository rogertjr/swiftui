//
//  ApiError.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "Unknown error :/"
        
        }
    }
}
