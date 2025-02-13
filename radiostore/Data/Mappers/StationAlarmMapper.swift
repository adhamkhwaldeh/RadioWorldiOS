//
//  StationAlarmMapper.swift
//  radiostore
//
//  Created by adham khwaldeh on 2/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation


class StationAlarmMapper{
   
   static func transform(poJo:Stations) -> StationAlarmDb{
       return StationAlarmDb(stationuuid: poJo.stationuuid, language: poJo.language, url: poJo.url, tags: poJo.tags, country: poJo.country, bitrate: poJo.bitrate, clickcount: poJo.clickcount, clicktrend: poJo.clicktrend, url_resolved:poJo.url_resolved , codec: poJo.codec, lastchangetime: poJo.lastchangetime, lastcheckok: poJo.lastcheckok, lastchecktime: poJo.lastchecktime, countrycode: poJo.countrycode, name: poJo.name, homepage: poJo.homepage, lastcheckoktime: poJo.lastcheckoktime, state: poJo.state, lastlocalchecktime: poJo.lastlocalchecktime, votes: poJo.votes, clicktimestamp: poJo.clicktimestamp, favicon: poJo.favicon, changeuuid: poJo.changeuuid, hls: poJo.hls)
    }

  static func transform(poJo:StationAlarmDb) -> Stations{
        return Stations(stationuuid: poJo.stationuuid, language: poJo.language, url: poJo.url, tags: poJo.tags, country: poJo.country, bitrate: poJo.bitrate, clickcount: poJo.clickcount, clicktrend: poJo.clicktrend, url_resolved:poJo.url_resolved , codec: poJo.codec, lastchangetime: poJo.lastchangetime, lastcheckok: poJo.lastcheckok, lastchecktime: poJo.lastchecktime, countrycode: poJo.countrycode, name: poJo.name, homepage: poJo.homepage, lastcheckoktime: poJo.lastcheckoktime, state: poJo.state, lastlocalchecktime: poJo.lastlocalchecktime, votes: poJo.votes, clicktimestamp: poJo.clicktimestamp, favicon: poJo.favicon, changeuuid: poJo.changeuuid, hls: poJo.hls)
    }
    
}
