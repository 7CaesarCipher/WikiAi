//
//  WikipediaCell.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 11/01/24.
//

import Foundation

import SwiftUI

struct WikipediaCell: View {
    var page: WikipediaPage

    var body: some View {
        VStack(alignment: .leading) {
            Text(page.title)
                .font(.headline)
            Text(page.extract)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}


struct WikipediaCell_Previews: PreviewProvider {
    static var previews: some View {
        let samplePage = WikipediaPage(pageid: 123, title: "Sample Title", extract: "Sample Extract", imageURL: nil)
        return WikipediaCell(page: samplePage)
    }
}
