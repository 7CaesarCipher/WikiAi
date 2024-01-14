//
//  MainViewModel.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//
import SwiftUI
import Combine

class WikipediaViewModel: ObservableObject {
    @Published var searchResults: [Page] = []
    private var cancellables: Set<AnyCancellable> = []

    func search(query: String) {
        print("Searching for: \(query)")
      
        guard var components = URLComponents(string: "https://en.wikipedia.org/w/api.php") else {
            return
        }
        components.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "generator", value: "search"),
            URLQueryItem(name: "gsrnamespace", value: "0"),
            URLQueryItem(name: "gsrsearch", value: query),
            URLQueryItem(name: "gsrlimit", value: "10"),
            URLQueryItem(name: "prop", value: "extracts|pageimages"),
            URLQueryItem(name: "pilimit", value: "max"),
            URLQueryItem(name: "exintro", value: ""),
            URLQueryItem(name: "explaintext", value: ""),
            URLQueryItem(name: "exsentences", value: "1"),
            URLQueryItem(name: "exlimit", value: "max")
        ]

        guard let url = components.url else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WikipediaResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // Receive on the main thread
            .sink { completion in
                switch completion {
                case .finished:
                    print("API request completed")
                case .failure(let error):
                    print("API request failed with error: \(error)")
                    // Handle the error, e.g., show an alert to the user
                }
            } receiveValue: { response in
                print("Received response: \(response)")
                self.searchResults = Array(response.query.pages.values)
            }
            .store(in: &cancellables)
    }
}
