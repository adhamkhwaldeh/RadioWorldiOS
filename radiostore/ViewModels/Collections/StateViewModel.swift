//
//  StateViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class StateViewModel : BaseCollectionViewModel<States> ,ObservableObject , Identifiable{
    
    override func getEndpoint(filter: String)-> Future<[States],Error> {
        return appClient.getStateList(filter: filter)
    }
    
}
