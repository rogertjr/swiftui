//
//  ArticleView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import SwiftUI

struct ArticleView: View {
    // MARK: - Properties
    let article: Article
    @Binding var isLoading: Bool
    
    // MARK: - UI Elements
    var body: some View {
        HStack {
            if let imageUrlString = article.image {
                AsyncImage(url: URL(string: imageUrlString), content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }, placeholder: {
                    placeholderImageView
                })
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            }
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(article.title ?? "")
                    .foregroundStyle(.primary)
                    .font(.system(size: 18, weight: .semibold))
                
                HStack(spacing: 8) {
                    Text(article.source ?? "N/A")
                        .foregroundStyle(.primary)
                        .font(.footnote)
                    
                    if let date = article.date {
                        Text(format(date, dateStyle: .short, timeStyle: .medium))
                            .foregroundStyle(.primary)
                            .font(.footnote)
                    }
                }
            })
        }
        .redacted(reason: isLoading ? .placeholder : [])
        .animatePlaceholder(isLoading: $isLoading)
    }
}

// MARK: - Builders
private extension ArticleView {
     var placeholderImageView: some View {
         RoundedRectangle(cornerRadius: 10)
             .frame(width: 100, height: 100)
             .foregroundStyle(.tertiary)
             .redacted(reason: .placeholder)
             .animatePlaceholder(isLoading: .constant(true))
    }
}

// MARK: - Preview
#Preview {
    Group {
        ArticleView(article: Article.sampleData.first!, isLoading: .constant(false))
        ArticleView(article: Article.sampleData.first!, isLoading: .constant(true))
    }
    .preferredColorScheme(.dark)
}
