//
//  ContentView.swift
//  Tiny Wins
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//

import SwiftUI
import WidgetKit

struct ContentView: View {

    @State private var count: Int = TinyWinsStore.shared.getCount()
    @State private var note: String = TinyWinsStore.shared.getNote()
    @State private var today: String = TinyWinsStore.shared.todayString()

    var body: some View {
        VStack(spacing: 18) {

            Text("Tiny Wins")
                .font(.largeTitle)
                .bold()

            Text("Today: \(today)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Wins: \(count)")
                .font(.title)

            Button("+1 Tiny Win") {
                count += 1
                TinyWinsStore.shared.setCount(count)
                WidgetCenter.shared.reloadAllTimelines()
            }
            .buttonStyle(.borderedProminent)

            VStack(alignment: .leading, spacing: 8) {
                Text("Today’s note")
                    .font(.headline)

                TextField("What was your tiny win today?", text: $note)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: note) { _, newValue in
                        // Optional: enforce a “limited text” rule
                        let capped = String(newValue.prefix(140))
                        if capped != newValue { note = capped }
                        TinyWinsStore.shared.setNote(note)
                        WidgetCenter.shared.reloadAllTimelines()
                    }

                Text("\(note.count)/140")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider().padding(.vertical, 6)

            Button("Start New Day (Reset)") {
                TinyWinsStore.shared.startNewDay()
                today = TinyWinsStore.shared.todayString()
                count = TinyWinsStore.shared.getCount()
                note = TinyWinsStore.shared.getNote()
                WidgetCenter.shared.reloadAllTimelines()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .onAppear {
            // Optional auto-reset behavior (you can remove if you don’t want it)
            TinyWinsStore.shared.autoResetIfNewDay()
            today = TinyWinsStore.shared.todayString()
            count = TinyWinsStore.shared.getCount()
            note = TinyWinsStore.shared.getNote()
        }
    }
}

#Preview {
    ContentView()
}
