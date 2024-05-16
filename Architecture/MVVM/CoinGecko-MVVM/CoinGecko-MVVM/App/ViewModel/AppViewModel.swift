//
//  AppViewModel.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import Foundation
import Combine

final class AppViewModel: ObservableObject {
    
    // MARK: - Properties
    private let service: CoinServiceProtocol
    
    @Published private(set) var error: CoinService.NetworkingError?
    @Published private(set) var state: ViewState = .idle
    @Published var hasError = false
    
    @Published private(set) var coins: [Coin] = []
    @Published private(set) var topMovingCoins: [Coin] = []
    
    @Published var searchedText: String = ""
    @Published var searchedCoins: [Coin]?
    @Published var sort: Sort = .asc
    
    private var page: Int = 1
    private var perPage: String = "50"
    
    var isLoading: Bool { return state == .isLoading }
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init(_ service: CoinServiceProtocol = CoinService()) {
        self.service = service
        
        $searchedText
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self else { return }
                if !search.isEmpty {
                    self.filterCoinsBySearch()
                } else {
                    self.searchedCoins = nil
                }
            }
            .store(in: &subscriptions)
        
        $sort
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self else { return }
                if let searchedCoins = self.searchedCoins, searchedCoins.count > 0 {
                    self.searchedCoins = self.sortCoins(searchedCoins)
                } else {
                    self.coins = self.sortCoins(self.coins)
                }
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Helpers
    private func resetData() {
        if state == .finishedLoading {
            state = .idle
            coins = []
            page = 1
        }
    }
    
    private func setUpTopMovingCoins() {
        let topMovers = coins.sorted(by: { $0.priceChangePercentage24H > $1.priceChangePercentage24H })
        topMovingCoins = Array(topMovers.prefix(5))
    }
    
    private func filterCoinsBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.coins
                .lazy
                .filter { [weak self] coin in
                    let symbolName = coin.symbol.lowercased().contains(self?.searchedText.lowercased() ?? "")
                    let coinName = coin.name.lowercased().contains(self?.searchedText.lowercased() ?? "")
                    return symbolName || coinName
                }

            DispatchQueue.main.async { [weak self] in
                self?.searchedCoins = results.compactMap({ $0 }).sorted(by: {
                    self?.sort == .asc ? $0.marketCapRank < $1.marketCapRank : $0.marketCapRank > $1.marketCapRank
                })
            }
        }
    }
    
    private func sortCoins(_ coinsToSort: [Coin]) -> [Coin] {
        coinsToSort.sorted(by: { [weak self] in
            self?.sort == .asc ? $0.marketCapRank < $1.marketCapRank : $0.marketCapRank > $1.marketCapRank
        })
    }
    
    func hasReachedEnd(of coin: Coin) -> Bool {
        coins.last?.symbol == coin.symbol
    }

    // MARK: - Networking
    @MainActor
    func fetchCoins() async {
        guard !isLoading else { return }
        resetData()
        
        state = .isLoading
        defer { state = .finishedLoading }
        
        do {
            let coinResponse = try await service.fetchAllCoins(String(page), perPage: perPage)
            coins += sortCoins(coinResponse)
            setUpTopMovingCoins()
            hasError = false
            HapticManager.notification(type: .success)
        } catch {
            state = .error("Failed to fetch coins")
            hasError = true
            if let networkingError = error as? CoinService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
    
    @MainActor
    func fetchNextPage() async {
        guard !isLoading else { return }
        page += 1
        state = .isLoading
        defer { state = .finishedLoading }
        
        do {
            let coinResponse = try await service.fetchAllCoins(String(page), perPage: perPage)
            coins += sortCoins(coinResponse)
            setUpTopMovingCoins()
            hasError = false
            HapticManager.notification(type: .success)
        } catch {
            state = .error("Failed to fetch coins")
            hasError = true
            if let networkingError = error as? CoinService.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error)
            }
        }
    }
}
