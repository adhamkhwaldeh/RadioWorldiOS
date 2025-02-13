//
//  CombineExtensions.swift
//  radiostore
//
//  Created by adham khwaldeh on 22/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
