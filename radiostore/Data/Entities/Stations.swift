//
//  Stations.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation

class Stations: NSData, Codable, Identifiable {

    var stationuuid: String? = ""

    var name: String? = ""

    var favicon: String? = ""

    var tags: String? = ""

    var language: String? = ""

    var countrycode: String? = ""

    var url: String? = ""


    var country: String? = ""
    var bitrate: Int? = 0
    var clickcount: Int? = 0
    var clicktrend: Int? = 0
    var url_resolved: String? = ""
    var codec: String? = ""
    var lastchangetime: String? = ""
    var lastcheckok: Int? = 1
    var lastchecktime: String? = ""
    var homepage: String? = ""
    var lastcheckoktime: String? = ""
    var state: String? = ""
    var lastlocalchecktime: String? = ""
    var votes: Int? = 0
    var clicktimestamp: String? = ""
    var changeuuid: String? = ""
    var hls: Int? = 0

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(stationuuid: String? = "", language: String? = "", url: String? = "",
         tags: String? = "", country: String? = "", bitrate: Int? = 0,
         clickcount: Int? = 0, clicktrend: Int? = 0, url_resolved: String? = "",
         codec: String? = "", lastchangetime: String? = "", lastcheckok: Int? = 1,
         lastchecktime: String? = "", countrycode: String? = "", name: String? = "",
         homepage: String? = "", lastcheckoktime: String? = "", state: String? = "",
         lastlocalchecktime: String? = "", votes: Int? = 0,
         clicktimestamp: String? = "", favicon: String? = "",
         changeuuid: String? = "", hls: Int? = 0) {
        super.init()

        self.stationuuid = stationuuid
        self.language = language
        self.url = url
        self.tags = tags
        self.country = country
        self.bitrate = bitrate
        self.clickcount = clickcount
        self.clicktrend = clicktrend
        self.url_resolved = url_resolved
        self.codec = codec
        self.lastchangetime = lastchangetime
        self.lastcheckok = lastcheckok
        self.lastchecktime = lastchecktime
        self.countrycode = countrycode
        self.name = name
        self.homepage = homepage
        self.lastcheckoktime = lastcheckoktime
        self.state = state
        self.lastlocalchecktime = lastlocalchecktime
        self.votes = votes
        self.clicktimestamp = clicktimestamp
        self.favicon = favicon
        self.changeuuid = changeuuid
        self.hls = hls


    }




//    static func getInstance( stationuuid :String? = "",language :String?="", url :String?="",
//                             tags :String?="",country :String?="", bitrate :Int? = 0,
//                             clickcount :Int?=0, clicktrend :Int?=0, url_resolved : String?="",
//                             codec : String?="", lastchangetime :String? = "", lastcheckok : Int?=1,
//                             lastchecktime : String? = "", countrycode :String? = "", name : String? = "",
//                             homepage : String?="", lastcheckoktime : String? = "",state : String? = "",
//                             lastlocalchecktime : String? = "", votes : Int? = 0,
//                             clicktimestamp : String? = "", favicon : String? = "",
//                             changeuuid : String? = "",  hls : Int? = 0)-> Stations{
//        let station = Stations()
////         station
//        return station
//    }

}
