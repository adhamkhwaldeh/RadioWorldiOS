//
//  TrendViewSection.swift
//  radiostore
//
//  Created by adham khwaldeh on 21/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import SwiftUI

struct TrendViewSection: View {

    @ObservedObject var viewModel = StationViewModel()

    @State private var selectedTab: TrendTabEnum = .top_click

    @State private var searchText = ""

    private func loadData() {
        viewModel.loadTrendStations(trendTabEnum: selectedTab, search: searchText)
    }

    init() {
        loadData()
    }

    var body: some View {
        VStack {
            Picker(selection: $selectedTab.onChange { (TrendTabEnum) in
                loadData()
            }, label: Text("What is your favorite color?")) {
                Text(Translation.TopClick).tag(TrendTabEnum.top_click)
                Text(Translation.TopVote).tag(TrendTabEnum.top_vote)
                Text(Translation.LastChange).tag(TrendTabEnum.last_change)
                Text(Translation.LastVisited).tag(TrendTabEnum.last_visited)
            }.pickerStyle(SegmentedPickerStyle())

            RadioCollectionListView(state: self.$viewModel.stationsTrendState, requestPull: loadData,
                                    requestReload: loadData, requestSearch: { query in
                                        searchText = query
                                        loadData()
                                    })

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }

}
