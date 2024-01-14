//
//  Wikipedia.Request.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//



import Foundation
import Combine


struct WikipediaPage: Identifiable {
    let id = UUID()
       let pageid: Int
       let title: String
       let extract: String
       let imageURL: URL?

    struct Thumbnail: Decodable {
            let source: URL
            let width: Int
            let height: Int
        }
}
