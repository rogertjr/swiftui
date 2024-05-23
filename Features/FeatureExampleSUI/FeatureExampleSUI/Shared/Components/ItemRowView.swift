//
//  ItemRowView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct ItemRowView<Content: View>: View {
    // MARK: - Properties
    var title: String
    var icon: String
    var content: () -> Content
    
    // MARK: - UI Elements
    var body: some View {
        NavigationLink {
            content()
                .padding(.horizontal)
        } label: {
            Label(title, systemImage: icon)
                .font(.headline)
                .padding(.vertical, 8)
                .foregroundStyle(.primary)
        }
    }
}
