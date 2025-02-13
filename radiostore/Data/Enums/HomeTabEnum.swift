//
//  HomeTabs.swift
//  radiostore
//
//  Created by adham khwaldeh on 21/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

enum HomeTabEnum: Hashable {
    case home
    case trends
    case favorites
    case alarm
    case settings

    public func getLocalName() -> LocalizedStringKey {
        switch self {
        case .home:
            return Translation.Home
        case .trends:
            return Translation.Trends
        case .favorites:
            return Translation.Favorites
        case .alarm:
            return Translation.Alarm
        case .settings:
            return Translation.Settings
        }
    }

}
