//
//  Strings+Flag.swift
//  radiostore
//
//  Created by adham khwaldeh on 10/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation


extension String {

    func flag() -> String { //country: String
        let base: UInt32 = 127397
        var flag = ""
        for v in self.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flag
    }

}
