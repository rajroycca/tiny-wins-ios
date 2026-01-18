//
//  ContentView.swift
//  Tiny Wins
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//

import SwiftUI

struct ContentView: View {

    @State private var count: Int = UserDefaults.standard.integer(forKey: "count")

    var body: some View {
        VStack(spacing: 20) {

            Text("Count: \(count)")
                .font(.largeTitle)

            Button("Increment") {
                count += 1
                UserDefaults.standard.set(count, forKey: "count")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
