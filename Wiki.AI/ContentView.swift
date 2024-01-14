//
//  ContentView.swift
//  Wiki.AI
//
//  Created by shashank Mishra on 10/01/24.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            WikipediaSearchView()
                .navigationBarTitle("Wikipedia Search")
        }
    }
}

#Preview {
    ContentView()
}
