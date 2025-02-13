//
//  NetworkState.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

enum NetworkState<T> {
    case loading
    case loadingDismiss
    case error(String)
    case content(T)

    var isLoading: Bool {
        set {
//            if(newValue) {
//                self = .loading
//            } else {
//                self = .loadingDismiss
//            }
        }
        get {
            switch(self) {
            case .loading:
                return true
            case .loadingDismiss:
                return false
            case .error(_):
                return false
            case .content(_):
                return false
            } //Error
        }

    }

}
