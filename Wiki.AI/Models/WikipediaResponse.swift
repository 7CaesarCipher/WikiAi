//
//  WikipediaResponse.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//

import SwiftUI
import Combine
struct WikipediaResponse: Codable {
    let batchcomplete: String
    let `continue`: Continue
    let query: Query
    let limits: Limits
}

struct Continue: Codable {
    let gsroffset: Int
    let `continue`: String
}

struct Query: Codable {
    let pages: [String: Page]
}
struct Page: Codable, Identifiable {
    let id: Int
    let pageid: Int
    let ns: Int
    let title: String
    let index: Int
    let thumbnail: Thumbnail?
    let extract: String
    let pageimage: String?

    enum CodingKeys: String, CodingKey {
        case pageid
        case ns
        case title
        case index
        case thumbnail
        case extract
        case pageimage
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.pageid = try container.decode(Int.self, forKey: .pageid)
        self.ns = try container.decode(Int.self, forKey: .ns)
        self.title = try container.decode(String.self, forKey: .title)
        self.index = try container.decode(Int.self, forKey: .index)
        self.thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        self.extract = try container.decode(String.self, forKey: .extract)
        self.pageimage = try container.decodeIfPresent(String.self, forKey: .pageimage)
        // Map "pageid" to "id" for Identifiable conformance
        self.id = pageid
    }
}


struct Thumbnail: Codable {
    let source: String
    let width: Int
    let height: Int
}

struct Limits: Codable {
    let pageimages: Int
    let extracts: Int
}
