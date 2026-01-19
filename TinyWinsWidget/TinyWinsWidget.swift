//
//  TinyWinsWidget.swift
//  TinyWinsWidget
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//

import WidgetKit
import SwiftUI

struct TinyWinsEntry: TimelineEntry {
    let date: Date
    let count: Int
    let note: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TinyWinsEntry {
        TinyWinsEntry(date: Date(), count: 3, note: "Walked 10 minutes")
    }

    func getSnapshot(in context: Context, completion: @escaping (TinyWinsEntry) -> Void) {
        completion(loadEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TinyWinsEntry>) -> Void) {
        let entry = loadEntry()

        // Refresh every 15 minutes (good enough for now)
        let next = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date().addingTimeInterval(900)
        completion(Timeline(entries: [entry], policy: .after(next)))
    }

    private func loadEntry() -> TinyWinsEntry {
        let store = TinyWinsStore.shared
        let entry = TinyWinsEntry(
            date: Date(),
            count: store.getCount(),
            note: store.getNote()
        )
        return entry
    }
}

struct TinyWinsWidgetView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tiny Wins")
                .font(.headline)

            Text("Wins: \(entry.count)")
                .font(.title2)
                .bold()

            if !entry.note.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(entry.note)
                    .font(.caption)
                    .lineLimit(3)
                    .foregroundStyle(.secondary)
            } else {
                Text("Add a note in the app")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

struct TinyWinsWidget: Widget {
    let kind: String = "TinyWinsWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TinyWinsWidgetView(entry: entry)
        }
        .configurationDisplayName("Tiny Wins")
        .description("Shows today’s win count and note.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
