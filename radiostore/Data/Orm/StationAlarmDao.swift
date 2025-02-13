//
//  StationAlarmDao.swift
//  radiostore
//
//  Created by adham khwaldeh on 1/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import GRDB

class StationAlarmDao: BaseDao<StationAlarmDb> {

    /*Channel Query started*/
    func orderedByName() -> QueryInterfaceRequest<StationAlarmDb> {
        return StationAlarmDb.order(StationAlarmDb.Columns.name)
    }

    func orderedByScore() -> QueryInterfaceRequest<StationAlarmDb> {
        return StationAlarmDb.order(StationAlarmDb.Columns.Guid.desc, StationAlarmDb.Columns.Guid)
    }

    func existed(stationuuid: String?) -> QueryInterfaceRequest<StationAlarmDb> {
        return StationAlarmDb.filter(stationuuid == StationAlarmDb.Columns.stationuuid)//(required: )(chnlId: in)
    }
    /*Channel Query ended*/

    
    @discardableResult
    func populateIfEmpty() throws -> Bool {
        return try database.write(_populateIfEmpty)
    }

    private func _populateIfEmpty(_ db: Database) throws -> Bool {
        if try StationAlarmDb.fetchCount(db) > 0 {
            return false
        }

        // Insert new random players
//        for _ in 0..<8 {
//            var player = Player(id: nil, name: Player.randomName(), score: Player.randomScore())
//            try player.insert(db)
//        }
        return true
    }


//    func refresh() -> Single<Void> {
//        return database.rx.write(updates: _refresh)
//    }

    private func _refresh(_ db: Database) throws {
        if try _populateIfEmpty(db) {
            return
        }
    }

//    func stressTest() -> Single<Void> {
//        return Single.zip(repeatElement(refresh(), count: 50))
//    }

}
