//
//  AppDatabase.swift
//  protv
//
//  Created by adham khwaldeh on 11/1/20.
//  Copyright © 2020 adham khwaldeh. All rights reserved.
//

import GRDB

/// A type responsible for initializing the application database.
///
/// See AppDelegate.setupDatabase()
struct AppDatabase {

    /// Prepares a fully initialized database at path
    func setup(_ database: DatabaseWriter) throws {
        // Use DatabaseMigrator to define the database schema
        // See https://github.com/groue/GRDB.swift/#migrations
        try migrator.migrate(database)

        // Other possible setup include: custom functions, collations,
        // full-text tokenizers, etc.
    }

    /// The DatabaseMigrator that defines the database schema.
    ///
    /// See https://github.com/groue/GRDB.swift/blob/master/README.md#migrations
    var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        #if DEBUG
            // Speed up development by nuking the database when migrations change
            migrator.eraseDatabaseOnSchemaChange = true
        #endif

        migrator.registerMigration("radioStor1.0") { db in
            // Create a table
            // See https://github.com/groue/GRDB.swift#create-tables
            // Sort player names in a localized case insensitive fashion by default
            // See https://github.com/groue/GRDB.swift/blob/master/README.md#unicode
            try db.create(table: "stationDb", temporary: false, ifNotExists: true) { t in
                t.autoIncrementedPrimaryKey("Guid")
                
                t.column("stationuuid", .text).collate(.localizedCaseInsensitiveCompare)
 
                t.column("language", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("url", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("tags", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("country", .text).collate(.localizedCaseInsensitiveCompare)
           
                t.column("bitrate", .integer)
                
                t.column("clickcount", .integer)
    
                t.column("clicktrend", .integer)
      
                t.column("url_resolved", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("codec", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("lastchangetime", .text).collate(.localizedCaseInsensitiveCompare)
      
                t.column("lastcheckok", .integer)
                
                t.column("lastchecktime", .text).collate(.localizedCaseInsensitiveCompare)
               
                t.column("countrycode", .text).collate(.localizedCaseInsensitiveCompare)
   
                t.column("name", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("homepage", .text).collate(.localizedCaseInsensitiveCompare)
               
                t.column("lastcheckoktime", .text).collate(.localizedCaseInsensitiveCompare)
             
                t.column("state", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("lastlocalchecktime", .text).collate(.localizedCaseInsensitiveCompare)
      
                t.column("votes", .integer)

                t.column("clicktimestamp", .text).collate(.localizedCaseInsensitiveCompare)
             
                t.column("favicon", .text).collate(.localizedCaseInsensitiveCompare)
         
                t.column("changeuuid", .text).collate(.localizedCaseInsensitiveCompare)
       
                t.column("hls", .integer)
                
                t.column("byterate", .text).collate(.localizedCaseInsensitiveCompare)

            }
            
            try db.create(table: "stationAlarmDb", temporary: false, ifNotExists: true) { t in
                t.autoIncrementedPrimaryKey("Guid")
                
                t.column("stationuuid", .text).collate(.localizedCaseInsensitiveCompare)
 
                t.column("language", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("url", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("tags", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("country", .text).collate(.localizedCaseInsensitiveCompare)
           
                t.column("bitrate", .integer)
                
                t.column("clickcount", .integer)
    
                t.column("clicktrend", .integer)
      
                t.column("url_resolved", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("codec", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("lastchangetime", .text).collate(.localizedCaseInsensitiveCompare)
      
                t.column("lastcheckok", .integer)
                
                t.column("lastchecktime", .text).collate(.localizedCaseInsensitiveCompare)
               
                t.column("countrycode", .text).collate(.localizedCaseInsensitiveCompare)
   
                t.column("name", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("homepage", .text).collate(.localizedCaseInsensitiveCompare)
               
                t.column("lastcheckoktime", .text).collate(.localizedCaseInsensitiveCompare)
             
                t.column("state", .text).collate(.localizedCaseInsensitiveCompare)
                
                t.column("lastlocalchecktime", .text).collate(.localizedCaseInsensitiveCompare)
      
                t.column("votes", .integer)

                t.column("clicktimestamp", .text).collate(.localizedCaseInsensitiveCompare)
             
                t.column("favicon", .text).collate(.localizedCaseInsensitiveCompare)
         
                t.column("changeuuid", .text).collate(.localizedCaseInsensitiveCompare)
       
                t.column("hls", .integer)
                
                t.column("byterate", .text).collate(.localizedCaseInsensitiveCompare)

            }

        }

//        migrator.registerMigration("fixtures") { db in
        // Populate the players table with random data
//            for _ in 0..<8 {
//                var player = Player(id: nil, name: Player.randomName(), score: Player.randomScore())
//                try player.insert(db)
//            }
//        }

//        // Migrations for future application versions will be inserted here:
//        migrator.registerMigration(...) { db in
//            ...
//        }

        return migrator

    }


    /// Creates a fully initialized database at path
       func openDatabase(atPath path: String) throws -> DatabaseQueue {
          // Connect to the database
          // See https://github.com/groue/GRDB.swift/blob/master/README.md#database-connections
          let dbQueue = try DatabaseQueue(path: path)

          // Define the database schema
          try migrator.migrate(dbQueue)

          return dbQueue
      }

}
