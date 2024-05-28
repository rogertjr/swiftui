//
//  CombineHomeView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import SwiftUI

struct CombineHomeView: View {
    // MARK: - Properties
    @StateObject private var combineViewModel = CombineHomeViewModel()
    @Environment(\.openURL) var openURL
        
    // MARK: - UI Elements
    var body: some View {
        Group {
            switch combineViewModel.state {
            case .success(let articles):
                List(articles) { item in
                    ArticleView(article: item, isLoading: .constant(false))
                        .onTapGesture {
                            fetchUrl(item.url)
                        }
                }
            case .failed(let error):
                ErrorView(error: error) {
                    combineViewModel.getArticles()
                }
            default:
                skeletonView()
            }
        }
        .navigationTitle(Text("News"))
        .task {
            combineViewModel.getArticles()
        }
    }
    
    @ViewBuilder
    private func skeletonView() -> some View {
        List {
            ForEach(Article.sampleData, id: \.self) { dummy in
                ArticleView(article: dummy, isLoading: .constant(true))
            }
        }
    }
    
    // MARK: - Helpers
    private func fetchUrl(_ url: String?) {
        guard let link = url, let url = URL(string: link) else { return }
        openURL(url)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CombineHomeView()
            .preferredColorScheme(.dark)
    }
}
