//
//  FavouriteViewSection.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct FavouriteViewSection: View {

    @ObservedObject var viewModel = StationFavoriteViewModel()

    @State private var searchText = ""

    private func loadList() {
        viewModel.loadFavoriteStationObserve(query: searchText)
    }

    init() {
        loadList()
    }

    var body: some View {
        VStack {
            RadioCollectionListView(state: self.$viewModel.favouriteStationsState,
                                    requestPull: {
                                        loadList()
                                    }, requestReload: {
                                        loadList()
                                    }, requestSearch: { query in
                                        searchText = query
                                        loadList()
                                    })
        }
    }

}
