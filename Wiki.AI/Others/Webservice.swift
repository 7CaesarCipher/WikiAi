//
//  Webservice.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 11/01/24.
//
import Foundation
import Combine

class WikipediaService {
    func search(query: String) -> AnyPublisher<WikipediaResponse, Error> {
        // Construct the URL for the Wikipedia API search endpoint
        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(query)&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max") else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        // Create a data task publisher for the API request
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data } // Extract the data from the response
            .decode(type: WikipediaResponse.self, decoder: JSONDecoder()) // Decode the JSON response
            .receive(on: DispatchQueue.main) // Ensure the publisher emits events on the main queue
            .eraseToAnyPublisher() // Erase the publisher type for encapsulation
    }
}
    
