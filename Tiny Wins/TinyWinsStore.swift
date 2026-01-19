//
//  TinyWinsStore.swift
//  Tiny Wins
//
//  Created by Rajorshi Roy Chowdhury on 18/01/26.
//


import Foundation

final class TinyWinsStore {
    static let shared = TinyWinsStore()

    // Must match the App Group you added in Signing & Capabilities
    private let suiteName = "group.com.rajroyc.tinywins"

    private var defaults: UserDefaults {
        UserDefaults(suiteName: suiteName) ?? .standard
    }

    private init() {}

    // Keys
    private let countKey = "tinywins.count"
    private let noteKey  = "tinywins.note"
    private let dateKey  = "tinywins.lastDate" // stored as ISO yyyy-MM-dd

    // MARK: - Public API

    func getCount() -> Int {
        defaults.integer(forKey: countKey)
    }

    func setCount(_ value: Int) {
        defaults.set(value, forKey: countKey)
    }

    func getNote() -> String {
        defaults.string(forKey: noteKey) ?? ""
    }

    func setNote(_ value: String) {
        defaults.set(value, forKey: noteKey)
    }

    func getLastDateString() -> String {
        defaults.string(forKey: dateKey) ?? ""
    }

    func setLastDateString(_ value: String) {
        defaults.set(value, forKey: dateKey)
    }

    func todayString() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_CA")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    func startNewDay() {
        setCount(0)
        setNote("")
        setLastDateString(todayString())
    }

    /// Optional nice behavior:
    /// If day changed since last open, reset automatically.
    func autoResetIfNewDay() {
        let today = todayString()
        let last = getLastDateString()
        if last.isEmpty {
            setLastDateString(today)
            return
        }
        if last != today {
            startNewDay()
        }
    }
}
