//
//  TagViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TagViewModel : BaseCollectionViewModel<Tags>,ObservableObject , Identifiable {
    
    override func getEndpoint(filter: String)-> Future<[Tags],Error> {
        return appClient.getTagList(filter: filter)
    }
    
}
