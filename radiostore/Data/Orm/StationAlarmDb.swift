//
//  StationAlarmDb.swift
//  radiostore
//
//  Created by adham khwaldeh on 1/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import GRDB

struct StationAlarmDb {
    
    var Guid: Int64?
    var stationuuid :String? = ""
    var language :String?=""
    var  url :String?=""
    var tags :String?=""
    var country :String?=""
    var bitrate :Int? = 0
    var clickcount :Int?=0
    var clicktrend :Int?=0
    var url_resolved : String?=""
    var codec : String?=""
    var lastchangetime :String? = ""
    var lastcheckok : Int?=1
    var lastchecktime : String? = ""
    var countrycode :String? = ""
    var name : String? = ""
    var homepage : String?=""
    var lastcheckoktime : String? = ""
    var  state : String? = ""
    var lastlocalchecktime : String? = ""
    var  votes : Int? = 0
    var clicktimestamp : String? = ""
    var favicon : String? = ""
    var changeuuid : String? = ""
    var hls : Int? = 0
   
}
//Codable,
extension StationAlarmDb: Hashable { }

extension StationAlarmDb: Codable, FetchableRecord, MutablePersistableRecord {

    // Define database columns from CodingKeys
    enum Columns {
        static let Guid = Column(CodingKeys.Guid)
        static let stationuuid = Column(CodingKeys.stationuuid)
        static let language = Column(CodingKeys.language)
        static let url = Column(CodingKeys.url)
        static let tags = Column(CodingKeys.tags)
        static let country = Column(CodingKeys.country)
        static let bitrate = Column(CodingKeys.country)
        static let clickcount = Column(CodingKeys.clickcount)
        static let clicktrend = Column(CodingKeys.clicktrend)
        static let url_resolved = Column(CodingKeys.url_resolved)
        static let codec = Column(CodingKeys.codec)
        static let lastchangetime = Column(CodingKeys.lastchangetime)
        static let lastcheckok = Column(CodingKeys.lastcheckok)
        static let lastchecktime = Column(CodingKeys.lastchecktime)
        static let countrycode = Column(CodingKeys.countrycode)
        static let name = Column(CodingKeys.name)
        static let homepage = Column(CodingKeys.homepage)
        static let lastcheckoktime = Column(CodingKeys.lastcheckoktime)
        static let state = Column(CodingKeys.state)
        static let lastlocalchecktime = Column(CodingKeys.lastlocalchecktime)
        static let votes = Column(CodingKeys.votes)
        static let clicktimestamp = Column(CodingKeys.clicktimestamp)
        static let favicon = Column(CodingKeys.favicon)
        static let changeuuid = Column(CodingKeys.changeuuid)
        static let hls = Column(CodingKeys.hls)
    
    }

    // Update a player id after it has been inserted in the database.
    mutating func didInsert(with rowID: Int64, for column: String?) {
        Guid = rowID
    }
}

