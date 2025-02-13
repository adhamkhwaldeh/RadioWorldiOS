//
//  StationAlarmViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 1/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation

class StationAlarmViewModel: BaseViewModel, ObservableObject, Identifiable {

    @Published var isAlarm: Bool = false
    func isAlarmStation(station: Stations) {
        let stationDao = Current.stationAlarmDao

        Current.stationAlarmDao.dbQueue.inDatabase({ db in
            let stationDb: StationAlarmDb? = try! stationDao.existed(stationuuid: station.stationuuid).fetchOne(db)
            isAlarm = (stationDb != nil)
            print("")
        })

    }

    func addAlarmStation(station: Stations) {
        var stationDb = StationAlarmMapper.transform(poJo: station)

        do {
            try Current.stationAlarmDao.dbQueue.inDatabase({ db in
                try stationDb.insert(db)
                isAlarm = true
                print("")
            })
        } catch _ {
            print("")
        }

    }


    func deleteAlarmStation(station: Stations) {
        let stationDao = Current.stationAlarmDao

        do {
            try Current.stationAlarmDao.dbQueue.inDatabase({ db in
                let stationDb: StationAlarmDb? = try! stationDao.existed(stationuuid: station.stationuuid).fetchOne(db)
                try stationDb?.delete(db)
                isAlarm = false
                print("")
            })
        } catch _ {
            print("")
        }

    }


    @Published var alarmStationsState: NetworkState<[Stations]> = NetworkState.loading

    func loadAlarmStation() {

        alarmStationsState = NetworkState.loading

        Current.stationAlarmDao.dbQueue.inDatabase({ db in
            let stationList: [StationAlarmDb] = try! StationAlarmDb.fetchAll(db)
            self.alarmStationsState = NetworkState.content(stationList.map(StationAlarmMapper.transform))
            print("")
        })

    }


}
