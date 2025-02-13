//
//  StringsFiles.swift
//  radiostore
//
//  Created by adham khwaldeh on 2/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

enum Translation {

    static var AppName: LocalizedStringKey {
        return "AppName"
    }

    static var Home: LocalizedStringKey {
        return "Home"
    }

    static var Trends: LocalizedStringKey {
        return "Trends"
    }

    static var Favorites: LocalizedStringKey {
        return "Favorites"
    }

    static var Favorite: LocalizedStringKey {
        return "Favorite"
    }

    static var UnFavorite: LocalizedStringKey {
        return "UnFavorite"
    }

    static var Alarm: LocalizedStringKey {
        return "Alarm"
    }

    static var UnAlarm: LocalizedStringKey {
        return "UnAlarm"
    }

    static var Settings: LocalizedStringKey {
        return "Settings"
    }

    static var Languages: LocalizedStringKey {
        return "Languages"
    }

    static var Tags: LocalizedStringKey {
        return "Tags"
    }

    static var Country: LocalizedStringKey {
        return "Country"
    }

    static var State: LocalizedStringKey {
        return "State"
    }

    static var Dark: LocalizedStringKey {
        return "Dark"
    }

    static var Light: LocalizedStringKey {
        return "Light"
    }

    static var English: LocalizedStringKey {
        return "English"
    }

    static var Arabic: LocalizedStringKey {
        return "Arabic"
    }

    static var TopClick: LocalizedStringKey {
        return "TopClick"
    }

    static var TopVote: LocalizedStringKey {
        return "TopVote"
    }

    static var LastChange: LocalizedStringKey {
        return "LastChange"
    }

    static var LastVisited: LocalizedStringKey {
        return "LastVisited"
    }

    static var ThemeMode: LocalizedStringKey {
        return "ThemeMode"
    }

    static var OurApplication: LocalizedStringKey {
        return "OurApplication"
    }

    static var OurApplicationContent: LocalizedStringKey {
        return "OurApplicationContent"
    }

    static var SelectYourCountry: LocalizedStringKey {
        return "SelectYourCountry"
    }

    static var SelectYourCountryContent: LocalizedStringKey {
        return "SelectYourCountryContent"
    }

    static var EnjoyWithUs: LocalizedStringKey {
        return "EnjoyWithUs"
    }

    static var EnjoyWithUsContent: LocalizedStringKey {
        return "EnjoyWithUsContent"
    }

    static var Search: LocalizedStringKey {
        return "Search"
    }

    static var General: LocalizedStringKey {
        return "General"
    }

    static var Loading: LocalizedStringKey {
        return "Loading"
    }

    static var Loaded_Successfully: LocalizedStringKey {
        return "Loaded_Successfully"
    }

    static var Retry: LocalizedStringKey {
        return "Retry"
    }

    static var Network_not_available: LocalizedStringKey {
        return "Network_not_available"
    }

    static var No_data_found: LocalizedStringKey {
        return "No_data_found"
    }

    static var Player_State: LocalizedStringKey {
        return "Player_State"
    }

    static func welcome(name: String) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("Welcome %@, this is my app", comment: ""), name)
    }

}
