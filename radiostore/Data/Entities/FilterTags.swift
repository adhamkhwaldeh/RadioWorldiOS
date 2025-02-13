//
//  FilterTags.swift
//  radiostore
//
//  Created by adham khwaldeh on 3/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation


class FilterTags: Identifiable {
    var id = UUID()
    
    var name: String = ""
    var filterType: FilterTypeEnum = FilterTypeEnum.LANGUAGE

    func withName(name: String, filterType: FilterTypeEnum) -> FilterTags {
        self.name = name
        self.filterType = filterType
        return self
    }

}
