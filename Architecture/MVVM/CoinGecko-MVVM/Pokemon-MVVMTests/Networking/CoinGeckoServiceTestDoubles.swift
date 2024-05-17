//
//  CoinGeckoServiceTestDoubles.swift
//  Pokemon-MVVMUITests
//
//  Created by Rogério do Carmo Toledo Júnior on 17/05/24.
//

import Foundation
@testable import CoinGecko_MVVM

final class CoinServiceMock: CoinServiceProtocol {
    // MARK: - Properties
    enum Scenario {
        case success, failure
        case custom(String)
    }
    
    var scenario: Scenario
    
    // MARK: - Init
    init(_ scenario: Scenario) {
        self.scenario = scenario
    }
    
    // MARK: - Methods
    func fetchAllCoins(_ page: String, perPage: String) async throws -> [Coin] {
        switch scenario {
        case .success:
            guard let coinsResult = try? JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self) else {
                throw CoinService.NetworkingError.invalidData
            }
            return coinsResult
        case .custom(let jsonFile):
            guard let coinsResult = try? JSONMapper.decode(jsonFile, type: [Coin].self) else {
                throw CoinService.NetworkingError.invalidData
            }
            return coinsResult
        case .failure:
            throw CoinService.NetworkingError.invalidData
        }
    }
}
