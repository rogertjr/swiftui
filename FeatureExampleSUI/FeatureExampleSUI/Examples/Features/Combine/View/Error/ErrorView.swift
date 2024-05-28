//
//  ErrorView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 28/05/24.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - Properties
    let error: Error
    let actionHandler: (() -> Void)
    
    // MARK: - Init
    internal init(error: Error, actionHandler: @escaping (() -> Void)) {
        self.error = error
        self.actionHandler = actionHandler
    }
    
    // MARK: - UI Elements
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundStyle(.primary)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom, 4)
            
            Text("Oops")
                .foregroundStyle(.primary)
                .font(.system(size: 30, weight: .heavy))
            
            Text(error.localizedDescription)
                .foregroundStyle(.primary)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(.vertical, 4)
            
            Button(action: actionHandler, label: {
                Text("Retry")
            })
            .padding(.vertical, 12)
            .padding(.horizontal, 30)
            .background(.blue)
            .foregroundStyle(.white)
            .font(.system(size: 15, weight: .heavy))
            .cornerRadius(10)
        }
    }
}

// MARK: - Preview
#Preview {
    ErrorView(error: ApiError.decodingError) {}
        .preferredColorScheme(.dark)
}
