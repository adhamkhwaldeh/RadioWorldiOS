//
//  SwiftUI+Navigation.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

extension View {

    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
    }

    func navigatePresentation<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: view,
                    isActive: binding
                ) {
                    EmptyView()
                }
            }.navigationBarHidden(true)
        }
    }

}

