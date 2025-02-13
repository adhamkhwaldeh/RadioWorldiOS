//
//  View_SnackBar.swift
//  radiostore
//
//  Created by adham khwaldeh on 16/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

    func snackBar(isShowing: Binding<Bool>,
                  text: Text,
                  actionText: Text? = nil,
                  action: (() -> Void)? = nil) -> some View {

        Snackbar(isShowing: isShowing,
                 presenting: self,
                 text: text,
                 actionText: actionText,
                 action: action)

    }

}
