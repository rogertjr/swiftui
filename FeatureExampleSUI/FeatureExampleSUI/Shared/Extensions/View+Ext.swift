//
//  View+Ext.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 24/05/24.
//

import SwiftUI

extension View {
    func format(_ date: Date, style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.locale = .autoupdatingCurrent
        return formatter.string(from: date)
    }
    
    func currencyString(_ value: Double, maxDigits: Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: .init(value: value)) ?? ""
    }
    
    var currencySymbol: String {
        let locale = Locale.autoupdatingCurrent
        return locale.currencySymbol ?? ""
    }
    
    func deferredRendering(for seconds: Double) -> some View {
        modifier(DeferredViewModifier(threshold: seconds))
    }
    
    func animatePlaceholder(isLoading: Binding<Bool>) -> some View {
        modifier(AnimatePlaceholderModifier(isLoading: isLoading))
    }
}
