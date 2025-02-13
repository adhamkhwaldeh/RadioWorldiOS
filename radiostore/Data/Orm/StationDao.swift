import Foundation
import GRDB

class StationDao: BaseDao<StationDb> {

    /*Channel Query started*/
    func orderedByName() -> QueryInterfaceRequest<StationDb> {
        return StationDb.order(StationDb.Columns.name)
    }

    func orderedByScore() -> QueryInterfaceRequest<StationDb> {
        return StationDb.order(StationDb.Columns.Guid.desc, StationDb.Columns.Guid)
    }

    func existed(stationuuid: String?) -> QueryInterfaceRequest<StationDb> {
        return StationDb.filter(stationuuid == StationDb.Columns.stationuuid)//(required: )(chnlId: in)
    }
    /*Channel Query ended*/

    
    @discardableResult
    func populateIfEmpty() throws -> Bool {
        return try database.write(_populateIfEmpty)
    }

    private func _populateIfEmpty(_ db: Database) throws -> Bool {
        if try StationDb.fetchCount(db) > 0 {
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
