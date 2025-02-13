//
//  SettingViewSection.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingViewSection: View {

    @EnvironmentObject var settings: SettingsRepository

    var body: some View {

        VStack {

            Form {
                Section(header: Text(Translation.General)) {
                    Picker(
                        selection: $settings.themeMode,
                        label: Text(Translation.ThemeMode)
                    ) {
                        ForEach(ColorScheme.allCases, id: \.self) {
                            Text(($0 == ColorScheme.dark) ? Translation.Dark : Translation.Light).tag($0)
                        }
                    }

                    Picker(
                        selection: $settings.language,
                        label: Text(Translation.Languages)
                    ) {
                        ForEach(SettingsRepository.languages, id: \.self) {
                            Text(($0 == SettingsRepository.languages.first) ? Translation.English : Translation.Arabic).tag($0)
                        }
                    }
                }
            }
        }

    }

}

