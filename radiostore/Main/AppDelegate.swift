//
//  AppDelegate.swift
//  radiostore
//
//  Created by adham on 12/6/20.
//  Copyright © 2020 adham. All rights reserved.
//
//
import UIKit
import GRDB
import AlamofireNetworkActivityLogger
import IQKeyboardManagerSwift

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        #if DEBUG
//            NetworkActivityLogger.shared.level = .debug
//
//            NetworkActivityLogger.shared.startLogging()
//        #endif
//
//        let dbQueue = try! setupQueue(application)
//        let dbPool = try! setupDatabase(application)
//
//        Current = AppDatabaseWorld(database: { dbPool }, dbQueue: { dbQueue }, dbPool: { dbPool })

        IQKeyboardManager.shared.enable = true


        return true
    }

    //Database setup

    private func dataBaseUrl () throws -> URL {
        return try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
    }

    private func setupDatabase(_ application: UIApplication) throws -> DatabasePool {

        let databaseURL = try dataBaseUrl()

        let dbPool = try DatabasePool(path: databaseURL.path)

        // Be a nice iOS citizen, and don't consume too much memory
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
//        dbPool.setupMemoryManagement(in: application)

//        // Setup the database
        try AppDatabase().setup(dbPool)

        return dbPool
    }

    private func setupQueue(_ application: UIApplication) throws -> DatabaseQueue {
        let databaseURL = try dataBaseUrl()
        let dbQueue = try DatabaseQueue(path: databaseURL.path)
        return dbQueue
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

