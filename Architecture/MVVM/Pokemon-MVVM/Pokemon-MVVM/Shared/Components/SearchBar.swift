//
//  SearchBar.swift
//  Pokemon-MVVM
//
//  Created by Rogério do Carmo Toledo Júnior on 15/05/24.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - Properties
    var placeholder: String
    @Binding var text: String
    @State private var isEditing = false
    @FocusState var isFocused: Bool
    
    // MARK: - Layout
    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .padding(10)
                .padding(.horizontal, 25)
                .background(Theme.detailBackground)
                .foregroundColor(Theme.text)
                .cornerRadius(8)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Theme.text)
                            .frame(minWidth: 0,
                                   maxWidth: .infinity,
                                   alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }){
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 12)
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.isEditing = true
                    isFocused = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil,
                                                    from: nil,
                                                    for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    isFocused = false
                }
            }
        }
    }
}

#Preview {
    SearchBar(placeholder: "Placeholder", text: .constant(""))
}
