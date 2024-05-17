//
//  CoinServiceTests.swift
//  Pokemon-MVVMTests
//
//  Created by Rogério do Carmo Toledo Júnior on 17/05/24.
//

import XCTest
@testable import CoinGecko_MVVM

final class CoinServiceTests: XCTestCase {
    // MARK: - Properties
    var sut: CoinServiceProtocol = CoinServiceMock(.success)
    
    // MARK: - Tests
    func testFetchAllCoinsSuccessfully() async throws {
        let page = "1"
        let perPage = "50"
        
        let coinsResult = try await sut.fetchAllCoins(page, perPage: perPage)
        let staticResult = try JSONMapper.decode(MockResultFiles.coinList.rawValue, type: [Coin].self)
        
        XCTAssertEqual(coinsResult, staticResult, "The returned response should be equal")
        XCTAssertEqual(coinsResult.count, 50, "The returned response count should be 50 items")
    }
}
