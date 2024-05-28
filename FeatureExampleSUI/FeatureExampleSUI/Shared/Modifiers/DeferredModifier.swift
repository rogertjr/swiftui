//
//  DeferredModifier.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

// A ViewModifier that defers its rendering until after the provided threshold surpasses
struct DeferredViewModifier: ViewModifier {
    // MARK: - Properties
    let threshold: Double
    @State private var shouldRender = false

    // MARK: - ViewModifier
    func body(content: Content) -> some View {
        _content(content)
            .onAppear {
               DispatchQueue.main.asyncAfter(deadline: .now() + threshold) {
                   self.shouldRender = true
               }
            }
    }

    // MARK: - Builder
    @ViewBuilder private func _content(_ content: Content) -> some View {
        if shouldRender {
            content
        } else {
            content
                .hidden()
        }
    }
}
