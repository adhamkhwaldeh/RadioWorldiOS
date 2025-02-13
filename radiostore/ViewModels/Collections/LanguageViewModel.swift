//
//  LanguageViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LanguageViewModel : BaseCollectionViewModel<Languages>,ObservableObject , Identifiable {
    
    override func getEndpoint(filter: String)-> Future<[Languages],Error> {
        return appClient.getLanguageList(filter: filter)
    }
    
}

