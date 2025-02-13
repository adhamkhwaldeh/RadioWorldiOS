//
//  RadioStore_App.swift
//  radiostore
//
//  Created by adham khwaldeh on 9/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import UIKit
import SwiftUI
import GRDB
import AlamofireNetworkActivityLogger
import FRadioPlayer

import AVKit
import AVFoundation
import MediaPlayer
import os.log

@main
struct FRadioPlayer_SwiftUIApp: App {

    var radioPlayer = RadioPlayerViewModel()
    var settingsRepository = SettingsRepository()

    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        #if DEBUG
            NetworkActivityLogger.shared.level = .debug

            NetworkActivityLogger.shared.startLogging()
        #endif


        Current = AppDatabaseWorld()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(radioPlayer)
                .environmentObject(settingsRepository)
        }
    }

}


