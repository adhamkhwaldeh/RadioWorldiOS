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
import SwiftUIRefresh
import FRadioPlayer

struct RadioCollectionListView: View {

    var requestPull: () -> Void

    var requestReload: () -> Void

    var requestSearch: (String) -> Void

    @Binding var poJoListState: NetworkState<[Stations]>

    @EnvironmentObject var radioPlayer: RadioPlayerViewModel

    init(state: Binding<NetworkState<[Stations]>>, requestPull: @escaping () -> Void,
         requestReload: @escaping () -> Void,
         requestSearch: @escaping (String) -> Void) {
        self._poJoListState = state
        self.requestPull = requestPull
        self.requestReload = requestReload
        self.requestSearch = requestSearch
    }

    var body: some View {

        VStack {
            CollectionListView<StationCell, Stations>(
                state: self.$poJoListState, requestPull: requestPull, requestReload: requestReload,
                requestSearch: requestSearch, builder: { poJo, poJoList in
                    StationCell(poJo: poJo, orginalList: poJoList)
                })

//            Spacer()
            VStack(spacing: 0) {
                #if !targetEnvironment(macCatalyst)
                    if radioPlayer.radio.playerState != FRadioPlayerState.urlNotSet {
                        NowPlayingView().environmentObject(radioPlayer)
                    }
                #endif
//                StateView().environmentObject(radioPlayer)
                TabIconsView().environmentObject(radioPlayer)
            }

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                maxHeight: .infinity, alignment: .center)

    }

}
