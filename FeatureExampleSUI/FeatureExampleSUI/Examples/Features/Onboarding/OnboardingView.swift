//
//  OnboardingView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 27/05/24.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Properties
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    private var pages: [OnboardingPage] = OnboardingPage.exampleData()
    @State private var selectedPage = 0
    @State private var hidePreviousButton: Bool = true
    @State private var hideNextButton: Bool = false
    
    // MARK: - UI Elements
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { isOnboarding = false }, label: {
                    Text(selectedPage == (pages.count - 1) ? "Done" : "Skip")
                        .tint(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
                })
                .padding(.horizontal)
            }
            
            TabView(selection: $selectedPage) {
                ForEach(pages.indices, id: \.self) { index in
                    OnboardingCardView(page: pages[index],
                                       hidePreviousButton: hidePreviousButton,
                                       hideNextButton: hideNextButton) {
                        if selectedPage > 0 {
                            withAnimation {
                                selectedPage -= 1
                                updateButtons()
                            }
                        }
                    } nextAction: {
                        if selectedPage < (pages.count - 1) {
                            withAnimation {
                                selectedPage += 1
                                updateButtons()
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onChange(of: selectedPage, { _, newValue in
                selectedPage = newValue
                updateButtons()
            })
            .padding(.vertical, 20)
        }
    }
    
    private func updateButtons() {
        hidePreviousButton = selectedPage == 0
        hideNextButton = selectedPage == (pages.count - 1)
    }
}

// MARK: - Builders
private extension OnboardingView {
    // MARK: - Onboarding Card Component
    struct OnboardingCardView: View {
        var page: OnboardingPage
        var hidePreviousButton: Bool
        var hideNextButton: Bool
        var previousAction: (() -> Void)
        var nextAction: (() -> Void)
        
        private enum Side {
            case left, right
        }
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) {
                    Spacer()
                    Image(systemName: page.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                        .foregroundStyle(.white)
                    
                    
                    Text(page.title)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    
                    
                    Text(page.description)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: 480)
                    
                    Spacer()
                    
                    HStack {
                        if !hidePreviousButton {
                            containedButtonView("Previous", iconName: "chevron.left", iconSide: .left, action: previousAction)
                        }
                        if !hideNextButton {
                            containedButtonView("Next", iconName: "chevron.right", iconSide: .right, action: nextAction)
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: page.gradientColors), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .padding(.horizontal, 20)
        }
        
        @ViewBuilder
        private func containedButtonView(_ text: String, 
                                         iconName: String,
                                         iconSide: Side,
                                         action: @escaping (() -> Void)) -> some View {
            Button(action: action, label: {
                HStack(spacing: 8) {
                    switch iconSide {
                    case .left:
                        Image(systemName: iconName)
                            .imageScale(.large)
                            .tint(.white)
                        
                        Text(text)
                            .foregroundStyle(.white)
                        
                    case .right:
                        Text(text)
                            .foregroundStyle(.white)
                        
                        Image(systemName: iconName)
                            .imageScale(.large)
                            .tint(.white)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
            })
        }
    }
}

// MARK: - Preview
#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
