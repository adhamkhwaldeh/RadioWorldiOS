//
//  CollectionListView.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Combine


struct CollectionListView<Content: View, T: Identifiable>: View {

    var requestPull: () -> Void

    var requestReload: () -> Void

    var requestSearch: (String) -> Void

    var destination: (T, [T]) -> Content

    @State private var searchText: String = ""

    @Binding var poJoListState: NetworkState<[T]>

    @ObservedObject var countDownTimer = CountDownTimer()

    init(state: Binding<NetworkState<[T]>>, requestPull: @escaping () -> Void,
         requestReload: @escaping () -> Void,
         requestSearch: @escaping (String) -> Void,
         @ViewBuilder builder: @escaping (T, [T]) -> Content) {
        self._poJoListState = state
        self.requestPull = requestPull
        self.requestReload = requestReload
        self.requestSearch = requestSearch
        self.destination = builder
    }

    var body: some View {

        NetworkStateListView(state: $poJoListState, requestPull: requestPull, requestReload: requestReload) { poJoList in

            VStack {

                SearchBarView(searchText: $searchText) {
                    self.requestSearch(searchText)
                }.padding(.vertical)

                if(poJoList.isEmpty) {
                    HStack {
                        Text(Translation.No_data_found)
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                            maxHeight: .infinity, alignment: .center)

                } else {
                    List(poJoList) { poJo in
                        destination(poJo, poJoList)
                    }.padding(0)
                        .pullToRefresh(isShowing: $poJoListState.isLoading) {
                        self.requestPull()
                    } .resignKeyboardOnDragGesture()
                }

            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }

}
