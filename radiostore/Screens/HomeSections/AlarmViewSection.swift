//
//  AlarmViewSection.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct AlarmViewSection: View {

    @ObservedObject var viewModel = StationAlarmViewModel()

    init() {
        viewModel.loadAlarmStation()
    }

    var body: some View {
        VStack {
            RadioCollectionListView(state: self.$viewModel.alarmStationsState, requestPull: {
                viewModel.loadAlarmStation()
            }, requestReload: {

            }, requestSearch: { query in

            })
        }//.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }

}
