//
//  SettingsRepository.swift
//  radiostore
//  Created by adham khwaldeh on 2/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import SwiftUI
import Combine

final class SettingsRepository: ObservableObject {

    static let languages = ["en", "ar"]

    private enum Keys {
        static let themeMode = "themeMode"
        static let language = "language"
        static let firstLaunch = "firstLaunch"
    }

    private let cancellable: Cancellable
    private let defaults: UserDefaults

    let objectWillChange = PassthroughSubject<Void, Never>()

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        defaults.register(defaults: [
            Keys.themeMode: "light",
            Keys.language: "en",
        ])

        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }

    var themeMode: ColorScheme {
        get {
            return (defaults.string(forKey: Keys.themeMode) == "dark") ? ColorScheme.dark : ColorScheme.light
        }
        set {
            defaults.set((newValue == ColorScheme.dark) ? "dark" : "light", forKey: Keys.themeMode)
        }
    }

    var language: String {
        get {
            return defaults.string(forKey: Keys.language) ?? SettingsRepository.languages.first!
        }
        set {
            defaults.set(newValue, forKey: Keys.language)
        }
    }

    var afterSplash: Bool {
        get {
            return defaults.bool(forKey: Keys.firstLaunch)
        }
        set {
            defaults.set(newValue, forKey: Keys.firstLaunch)
        }
    }

}
