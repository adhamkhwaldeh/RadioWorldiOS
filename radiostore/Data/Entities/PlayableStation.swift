//
//  PlayableStation.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation

class PlayableStation:NSData, Codable ,Identifiable{
    
    var message : String? =  ""
    var stationuuid :String? = ""
    var ok : Bool? = false
    var name :String? = ""
    var url :String? = ""

}
