//
//  OnboardingPage.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 27/05/24.
//

import SwiftUI

struct OnboardingPage: Identifiable, Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
    let gradientColors: [Color]
    
    static func exampleData() -> [OnboardingPage] {
        [
            .init(imageName: "lightbulb", title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", gradientColors: [Color(.blue), Color(.black)]),
            .init(imageName: "star.lefthalf.fill", title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", gradientColors: [Color(.red), Color(.black)]),
            .init(imageName: "number.circle", title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", gradientColors: [Color(.blue), Color(.black)]),
            .init(imageName: "paperplane", title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", gradientColors: [Color(.red), Color(.black)])
        ]
    }
}
