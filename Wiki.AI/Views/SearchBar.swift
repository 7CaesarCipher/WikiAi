//
//  SearchBar.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 11/01/24.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Search...", text: $text, onEditingChanged: { editing in
                if !editing {
                    onSearch()
                }
            }, onCommit: {
                onSearch()
            })
            .padding(.horizontal, 10)
            .frame(height: 40)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .textFieldStyle(PlainTextFieldStyle())
            Button(action: {
                onSearch()
            }) {
                Text("Search")
            }
            .buttonStyle(BorderlessButtonStyle()) 
        }
        .padding()
    }
}
