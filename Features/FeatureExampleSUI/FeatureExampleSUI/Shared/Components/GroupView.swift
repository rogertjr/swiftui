//
//  GroupView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 23/05/24.
//

import SwiftUI

struct GroupView<Content: View>: View {
    // MARK: - Properties
    var title: String
    let content: () -> Content
    
    // MARK: - UI Elements
    var body: some View {
        return List {
            content()
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(title, displayMode: .inline)
    }
}

// MARK: - Preview
#Preview {
    GroupView(title: "Group", content: { Text("Content") })
        .previewLayout(.sizeThatFits)
}
