//
//  MainViewModel.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//
import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var wikipediaResponse: WikipediaResponse?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchWikipedia(query: searchText)
            }
            .store(in: &cancellables)
    }
    
    func searchWikipedia(query: String) {
        let urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(query)&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: WikipediaResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error fetching data: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] response in
                self?.wikipediaResponse = response
            }
            .store(in: &cancellables)
    }
}
