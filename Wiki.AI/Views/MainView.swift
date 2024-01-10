//
//  MainView.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List($viewModel.wikipediaResponse.query.pages ?? []) { page in
                    WikipediaCell(page: page)
                }
            }
            .navigationTitle("Wikipedia Search")
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
        }
    }
}

struct WikipediaCell: View {
    let page: WikipediaPage
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(page.title)
                .font(.headline)
            Text(page.extract)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
