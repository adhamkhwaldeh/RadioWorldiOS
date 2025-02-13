//
//  View+KeyboardExtensions.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import Combine

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}
