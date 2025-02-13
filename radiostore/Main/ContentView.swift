//
//  ContentView.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct ContentView: View {

    @EnvironmentObject var settingsRepository: SettingsRepository

    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
//        UITableView.appearance().backgroundColor = (self.settings.themeMode == ColorScheme.light) ? .secondarySystemFill : .tertiarySystemBackground
    }

    var body: some View {

        VStack {
            if settingsRepository.afterSplash {
                HomeScreenView()
            } else {
                SplashScreenView()
            }
        }.background(Color.blue.edgesIgnoringSafeArea(.all))
            .environment(\.locale, .init(identifier: settingsRepository.language))
            .environment(\.layoutDirection, Locale(identifier: settingsRepository.language).layoutDirection)
            .environment(\.colorScheme, settingsRepository.themeMode)
    }

}

#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static let settingsRepository = SettingsRepository()

        static var previews: some View {
            Group {
                ForEach([ColorScheme.light, ColorScheme.dark], id: \.self) { colorScheme in
                    ForEach(["en", "ar"], id: \.self) { identifier in
                        ContentView()
                            .environment(\.colorScheme, colorScheme)
                            .environment(\.locale, .init(identifier: identifier))
                            .previewLayout(.sizeThatFits)
                    }
                }
            }.environmentObject(settingsRepository)
                .environment(\.locale, .init(identifier: "ar"))
        }

    }
#endif
