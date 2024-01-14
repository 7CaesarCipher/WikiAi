//
//  MainView.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//
import SwiftUI
import CoreGraphics
struct WikipediaSearchView: View {
    @StateObject var viewModel = WikipediaViewModel()
    @State private var query: String = "Apple"
    
    var body: some View {
        VStack {
            HStack {
                SearchBar(text: $query, onSearch: { 
                    viewModel.search(query: query)
                })
            }
            .padding()
            List(viewModel.searchResults) { page in
                HStack {
                    if let thumbnail = page.thumbnail {
                        AsyncImage(url: URL(string: thumbnail.source)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(page.title)
                            .font(.headline)
                        Text(page.extract)
                            .font(.subheadline)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding()
        }
        .onAppear {
            viewModel.search(query: query)
        }
    }
}
struct WikipediaSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WikipediaSearchView()
        
    }
}
