//
//  CountryViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CountryViewModel : BaseCollectionViewModel<Countries>,ObservableObject , Identifiable{
 
    override func getEndpoint(filter: String)-> Future<[Countries],Error> {
        return appClient.getCountryList(filter: filter)
    }
    
}
