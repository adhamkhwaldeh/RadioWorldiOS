//
//  AppDatabaseWorld.swift
//  protv
//
//  Created by adham khwaldeh on 11/1/20.
//  Copyright © 2020 adham khwaldeh. All rights reserved.
//

import Foundation
import GRDB

/// Dependency Injection based on the "How to Control the World" article:
/// https://www.pointfree.co/blog/posts/21-how-to-control-the-world
struct AppDatabaseWorld {

    func dataBaseUrl () throws -> URL {
        return try FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
    }

    private lazy var dbQueue: DatabaseQueue = try! {
        let databaseURL = try dataBaseUrl()
        let dbQueue = try DatabaseQueue(path: databaseURL.path)
        return dbQueue
    }()

    private lazy var dbPool: DatabasePool = try! {
        let databaseURL = try dataBaseUrl()

        let dbPool = try DatabasePool(path: databaseURL.path)

        // Be a nice iOS citizen, and don't consume too much memory
        // See https://github.com/groue/GRDB.swift/blob/master/README.md#memory-management
//        dbPool.setupMemoryManagement(in: application)

//        // Setup the database
        try AppDatabase().setup(dbPool)

        return dbPool
    }()

    private lazy var database: DatabaseWriter = {
        return { self.dbQueue }()
    }()


    /// Access to the players database
    lazy var stationDao: StationDao = { return StationDao(database: database, dbQueue: dbQueue, dbPool: dbPool) }()

    lazy var stationAlarmDao: StationAlarmDao = { return StationAlarmDao(database: database, dbQueue: dbQueue, dbPool: dbPool) }()


    /// Creates a World with a database
//    init(database: @escaping () -> DatabaseWriter, dbQueue: @escaping() -> DatabaseQueue, dbPool: @escaping() -> DatabasePool) {
//    init() {
//
//    }

}

var Current = AppDatabaseWorld()


//var Current = AppDatabaseWorld(database: { fatalError("Database is uninitialized") }, dbQueue: { fatalError("Database is uninitialized") }, dbPool: { fatalError("Database is uninitialized") })





