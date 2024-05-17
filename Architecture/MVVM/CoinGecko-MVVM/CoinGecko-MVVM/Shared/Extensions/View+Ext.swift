//
//  View+Ext.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

extension View {
    func deferredRendering(for seconds: Double) -> some View {
        modifier(DeferredViewModifier(threshold: seconds))
    }
    
    func animatePlaceholder(isLoading: Binding<Bool>) -> some View {
        modifier(AnimatePlaceholderModifier(isLoading: isLoading))
    }
}
