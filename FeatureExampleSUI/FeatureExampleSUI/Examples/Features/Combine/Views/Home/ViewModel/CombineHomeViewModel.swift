//
//  CombineHomeViewModel.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import Foundation
import Combine

class CombineHomeViewModel: ObservableObject {
    // MARK: - Properties
    private var service: NewsServiceProtocol
    private (set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .idle
    @Published var isLoading: Bool = false
    
    // MARK: - Init
    init(_ service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }
    
    // MARK: - Networking
    func getArticles() {
        state = .loading
        isLoading = true
        
        defer { isLoading = false }
        
        service
            .request(from: .getNews)
            .sink { [weak self] result in
                guard let self else { return }
                switch result {
                case .finished:
                    self.state = .success(content: self.articles)
                    break
                case .failure(let error):
                    self.state = .failure(error: error)
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self else { return }
                self.articles = response.articles.filter({ !($0.title?.contains("[Removed]") ?? false) })
            }
            .store(in: &cancellables)
    }
}
