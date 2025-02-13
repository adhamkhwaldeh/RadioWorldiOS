//
//  HomeViewSection.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
//import EnvironmentOverrides
import FRadioPlayer


struct HomeViewSection: View {

    @ObservedObject private var viewModel = StationViewModel()

    @State private var searchText: String = ""

    @State private var bottomSheetViewType: ActiveSheet?

//    @Environment(\.locale) var locale: Locale
//
//    @Environment(\.colorScheme) var colorScheme: ColorScheme

    private func loadList() {
        viewModel.loadStations(search: searchText, filterby: viewModel.filterTags)
    }

    init() {
        loadList()
    }

    var body: some View {

        VStack {
            Picker(selection: $bottomSheetViewType, label: Text("What is your favorite color?")) {
                Text(Translation.Languages).tag(ActiveSheet.language as ActiveSheet?)
                Text(Translation.Tags).tag(ActiveSheet.tags as ActiveSheet?)
                Text(Translation.Country).tag(ActiveSheet.country as ActiveSheet?)
                Text(Translation.State).tag(ActiveSheet.state as ActiveSheet?)
            }.pickerStyle(SegmentedPickerStyle())

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.filterTags) { filterItem in
//                    for filterItem in viewModel.filterTags {
                        HStack {
                            Image.init(systemName: "multiply").font(.subheadline)
                            Text(filterItem.name).font(.subheadline).lineLimit(1)
                        }.padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(40)
                            .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.blue, lineWidth: 1.0)
                        ).onTapGesture {
                            let index = viewModel.filterTags.firstIndex(where: { $0.name == filterItem.name })
                            if(index != nil) {
                                viewModel.filterTags.remove(at: index!)
                                loadList()
                            }
                        }
                    }
                }.padding(.horizontal)
            }.frame(height: viewModel.filterTags.count == 0 ? 0 : 40, alignment: .top)

            RadioCollectionListView(state: self.$viewModel.stationsHomeState, requestPull: loadList,
                                    requestReload: loadList, requestSearch: { query in
                                        searchText = query
                                        loadList()
                                    })
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                       maxHeight: .infinity, alignment: .topLeading)

        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                maxHeight: .infinity, alignment: .topLeading)
            .sheet(item: $bottomSheetViewType) { item in
            switch item {
            case .language:
                LanguageScreenView(filterTags: $viewModel.filterTags, afterFilterChange: onFilterChange)
//                    .environment(\.colorScheme, self.colorScheme)
//                    .environment(\.locale, self.locale)
            case .tags:
                TagsScreenView(filterTags: $viewModel.filterTags, afterFilterChange: onFilterChange)
//                    .environment(\.colorScheme, self.colorScheme)
//                    .environment(\.locale, self.locale)
            case .country:
                CountryScreenView(filterTags: $viewModel.filterTags, afterFilterChange: onFilterChange)
//                    .environment(\.colorScheme, self.colorScheme)
//                    .environment(\.locale, self.locale)
            case .state:
                StateScreenView(filterTags: $viewModel.filterTags, afterFilterChange: onFilterChange)
//                    .environment(\.colorScheme, self.colorScheme)
//                    .environment(\.locale, self.locale)
            }
        }
//        .environment(\.colorScheme, self.colorScheme)
//            .environment(\.locale, self.locale)

    }

    func onFilterChange(poJoList: [FilterTags]) {
        self.bottomSheetViewType = nil
        loadList()
    }

}
