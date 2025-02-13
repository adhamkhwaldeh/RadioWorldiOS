//
//  States.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation

class States:  NSData, Codable ,Identifiable{
    var name :String? = ""
    var country :String? = ""
    var stationcount :Int? = 0
}
