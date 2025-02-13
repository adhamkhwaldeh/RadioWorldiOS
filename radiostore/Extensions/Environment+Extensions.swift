//
//  Environment+Extensions.swift
//  radiostore
//
//  Created by adham khwaldeh on 16/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

extension Locale {

    var isLTR: Bool {
        get { languageCode == "en" }
    }

    var layoutDirection: LayoutDirection {
        get { isLTR ? LayoutDirection.leftToRight : LayoutDirection.rightToLeft }
    }

    var isArabic: Bool {
        get { languageCode == "ar" }
    }

}


extension ColorScheme {

    var isDark: Bool {
        get { self == ColorScheme.dark }
    }

}
