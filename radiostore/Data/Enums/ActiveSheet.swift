//
//  ActiveSheet.swift
//  radiostore
//
//  Created by adham khwaldeh on 14/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation

enum ActiveSheet: Identifiable {
    case language, tags, country, state

    var id: Int {
        hashValue
    }
}
