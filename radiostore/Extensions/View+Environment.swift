//
//  View+Environment.swift
//  radiostore
//
//  Created by adham khwaldeh on 3/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

    public func maxSize() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }

}
