//
//  ButtonsView.swift
//  FeatureExampleSUI
//
//  Created by Rogério do Carmo Toledo Júnior on 27/05/24.
//

import SwiftUI
import AuthenticationServices

struct ButtonsView: View {
    @State private var showingAlert = false
    @State private var showingSheet = false
    @State private var showingActionSheet = false
    @State private var showButtonSheet = false
    
    var body: some View {
        Form {
            actionSection
            linkSection
            menuSection
        }
        .navigationTitle("Buttons")
        .toolbarRole(.editor)
        .scrollContentBackground(.hidden)
    }
}

private extension ButtonsView {
    var actionSection: some View {
        Section("Actions") {
            Button(action: { self.showingAlert = true }) {
                Text("Show Alert").bold()
            }
            .tint(appTint)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Title"),
                      message: Text("Message"),
                      primaryButton: .default(Text("Confirm")),
                      secondaryButton: .destructive(Text("Cancel")))
            }
            
            Button(action: { self.showingSheet = true }) {
                Text("Show Sheet").bold()
            }
            .tint(appTint)
            .sheet(isPresented: $showingSheet) {
                VStack {
                    Spacer()
                    
                    Button(action: { showingSheet.toggle() }) {
                        Text("Dismiss")
                            .bold()
                    }
                    .padding(.bottom)
                }
                .presentationDetents([.fraction(0.4)])
            }
            
            Button(action: { self.showingActionSheet = true }) {
                Text("Show Action Sheet").bold()
            }
            .tint(appTint)
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Title"), 
                            message: Text("Message"),
                            buttons: [ .destructive(Text("Delete")),
                                       .default(Text("Option 1")) { },
                                       .default((Text("Option 2"))) { },
                                       .cancel() ])
            }
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var linkSection: some View {
        Section("Links") {
            Link(destination: URL(string: "https://www.apple.com")!, label: {
                Text("Go to Store")
                    .bold()
                    .tint(appTint)
            })
            
            NavigationLink(destination: Text("Destination")) {
                Text("Go to next screen")
                    .bold()
            }
            
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { _ in })
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
    
    var menuSection: some View {
        Section("Menus") {
            Group {
                Menu("Show Menu") {
                    Button("Button") {}
                    Button("Button") {}
                    Menu("Submenu") {
                        Button("Button") {}
                        Button("Button") {}
                        Button("Button") {}
                    }
                    Divider()
                    Button("Button") {}
                    Menu("Submenu") {
                        Button("Button") {}
                        Button("Button") {}
                        Button("Button") {}
                    }
                }
                .tint(appTint)
                .bold()
                
                HStack {
                    Text("Show Context Menu")
                    Spacer()
                    Text("Press & hold")
                        .italic()
                        .bold()
                        .foregroundColor(.secondary)
                }
                .contextMenu {
                    Button("Button") {}
                    Button("Button") {}
                    Button("Button") {}
                    Divider()
                    Button("Button") {}
                    Button("Button") {}
                }
            }
            
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    ButtonsView()
}
