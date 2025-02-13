//
//  StationFavoriteViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 1/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import GRDB

class StationFavoriteViewModel: BaseViewModel, ObservableObject, Identifiable {


    func addFavouriteStation(station: Stations) {
//        let stationDao = Current.stationDao()
        var stationDb = StationMapper.transform(poJo: station)

        do {
            try Current.stationDao.dbQueue.inDatabase({ db in
                try stationDb.insert(db)
                print("")
            })
        } catch _ {
            print("")
        }

//        stationDao.insertOne(poJo: StationMapper.transform(poJo:station))
//            .sink (receiveCompletion: { completion in
//                switch completion {
//                                       case .finished:
//                                           break
//                                       case .failure(let error):
//                                           break
//                               }
//                }, receiveValue: { (Void) in
//                self.isFavouriteStation(station: station)
//                print("complete")
//            })

    }

    func deleteFavouriteStation(station: Stations) {
        let stationDao = Current.stationDao

        do {
            try Current.stationDao.dbQueue.inDatabase({ db in
                let stationDb: StationDb? = try! stationDao.existed(stationuuid: station.stationuuid).fetchOne(db)
                try stationDb?.delete(db)
                print("")
            })
        } catch _ {
            print("")
        }

//        stationDao.insertOne(poJo: StationMapper.transform(poJo:station))
//            .sink (receiveCompletion: { completion in
//                switch completion {
//                                       case .finished:
//                                           break
//                                       case .failure(let error):
//                                           break
//                               }
//                }, receiveValue: { (Void) in
//                self.isFavouriteStation(station: station)
//                print("complete")
//            })

    }


    @Published var isFavourite: Bool = false

    func isFavouriteStation(station: Stations) {

        let observation = ValueObservation.tracking { db in
            try StationDb.filter(station.stationuuid == StationDb.Columns.stationuuid).fetchOne(db)
        }
        var cancellable: Cancellable? = nil
        cancellable = observation.publisher(in: Current.stationDao.dbQueue).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    cancellable?.cancel()
                    cancellable = nil
                    break
                }
            }, receiveValue: { (station: StationDb?) in
//                cancellable?.cancel()
//                cancellable = nil
                self.isFavourite = (station != nil)
            })

//        let stationDao = Current.stationDao()
//
////        StationDb.filter(station.stationuuid! == StationDb.Columns.stationuuid)
//        Current.stationDao().dbQueue.inDatabase({ db in
////            let stationList:[StationDb] = StationDb.fetchOne(T##statement: SelectStatement##SelectStatement)All(db)
////            let stationuuid:String = station.stationuuid!
//            let stationDb: StationDb? = try! stationDao.existed(stationuuid: station.stationuuid).fetchOne(db)
//            isFavourite = (stationDb != nil)
////            try! StationDb.filter(stationuuid == StationDb.Columns.stationuuid).fetchOne(db)
////            try Link.filter(Column("url") == url).fetchOne(db)
////                stationDao.observeQueryOne(try! )
////            StationDb.filter(stationDao.existed(stationuuid: station.stationuuid))
////            self.favouriteStationsState = NetworkState.content(stationList.map(StationMapper.transform))
//            print("")
//        })

//        stationDao.observeQueryOne(stationDao.existed(stationuuid: station.stationuuid))
//            .sink { (subscribe:Subscribers.Completion<Error>) in
//                print("complete")
//            } receiveValue: { (stationDb:StationDb?) in
//                self.isFavourite = (stationDb != nil)
////                completion(stationDb)
//                print("complete")
//            }


    }


    @Published var favouriteStationsState: NetworkState<[Stations]> = NetworkState.loading

    func loadFavoriteStationObserve(query: String) {
        favouriteStationsState = NetworkState.loading
        let observation = ValueObservation.tracking { db in
            try StationDb.fetchAll(db, sql: "SELECT * FROM stationDb WHERE name LIKE \'%" + query + "%\' ORDER BY Guid DESC ")
            //, arguments: ["name": query])
        }
        var cancellable: Cancellable? = nil
        cancellable = observation.publisher(in: Current.stationDao.dbQueue).sink(
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    cancellable?.cancel()
                    cancellable = nil
                    break
                }
            }, receiveValue: { (stationList: [StationDb]) in
//                cancellable?.cancel()
//                cancellable = nil
                self.favouriteStationsState = NetworkState.content(stationList.map(StationMapper.transform))
            })
    }

//    func loadFavoriteStation() {
////        let stationDao = Current.stationDao()
//        favouriteStationsState = NetworkState.loading
//
////        do {
//        Current.stationDao().dbQueue.inDatabase({ db in
//            let stationList: [StationDb] = try! StationDb.fetchAll(db)
//            self.favouriteStationsState = NetworkState.content(stationList.map(StationMapper.transform))
//            print("")
//        })
////        } catch _ {
////            print("")
////        }
//
////       var _ = stationDao.observeAll()
////            .sink { (subscribe:Subscribers.Completion<Error>) in
////                print("complete")
////            } receiveValue: { (stationList:[StationDb]) in
////                self.favouriteStationsState = NetworkState.loadingDismiss
////                self.favouriteStationsState = NetworkState.content(stationList.map(StationMapper.transform))
//////                completion(stationDb)
////                print("complete")
////            }
//    }

}
