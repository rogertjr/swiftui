//
//  HomeView.swift
//  CoinGecko-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 16/05/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @StateObject private var viewModel = AppViewModel()
    @State private var isRotating: Bool = false
    @State private var isPresentingSearchBar: Bool = false
    
    // MARK: - Layout
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                TopMoversView()
                    .environmentObject(viewModel)
                
                Divider()
                    .padding(.horizontal)
                
                AllCoinsView()
                    .environmentObject(viewModel)
                
                if case .isLoading = viewModel.state {
                   ProgressView("Loading...")
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .foregroundStyle(Theme.textColor.opacity(0.5))
                       .padding(.top)
               }
            }
            .navigationTitle("Live Prices")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: { refreshToolbarButton })
                ToolbarItem(placement: .navigationBarTrailing, content: { sortToolbarButton })
            }
            .onTapGesture { UIApplication.shared.endEditing() }
        }
        .searchable(text: $viewModel.searchedText, placement: .automatic)
        .autocorrectionDisabled(true)
        .task { await viewModel.fetchCoins() }
        .alert(isPresented: $viewModel.hasError, error: viewModel.error) {
            Button("Retry", role: .cancel) {
                Task { await viewModel.fetchCoins() }
            }
            Button("Cancel", role: .destructive) { }
        }
    }
}

// MARK: - Views
private extension HomeView {
    var refreshToolbarButton: some View {
        Button {
            Task {
                isRotating.toggle()
                await viewModel.fetchCoins()
            }
        } label: {
            Image(systemName: "goforward")
                .font(.caption)
                .foregroundStyle(Theme.textColor)
                .rotationEffect(Angle.degrees(isRotating ? 360 : 0))
                .animation(.easeOut, value: isRotating)
        }
    }
    
    var sortToolbarButton: some View {
        Menu {
            Section {
                Text("Sort")
                Picker(selection: $viewModel.sort) {
                    Label("Ascending", systemImage: "arrow.up").tag(Sort.asc)
                    Label("Descending", systemImage: "arrow.down").tag(Sort.desc)
                } label: {
                    Text("Sort By")
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .font(.caption)
                .foregroundStyle(Theme.textColor)
        }
    }
}

// MARK: - PreviewProvider
#Preview {
    HomeView()
}
