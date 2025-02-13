//
//  CountryScreenView.swift
//  radiostore
//
//  Created by adham khwaldeh on 1/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct CountryScreenView: View {

    @ObservedObject var viewModel = CountryViewModel()

    @Binding private var filterTags: [FilterTags]

    private var afterFilterChange: ([FilterTags]) -> Void

    init(filterTags: Binding<[FilterTags]>, afterFilterChange: @escaping ([FilterTags]) -> Void) {
        self._filterTags = filterTags
        self.afterFilterChange = afterFilterChange
        viewModel.loadPoJoList(filter: "")
    }

    private func submitPoJo(poJo: Countries) {
        let index = filterTags.firstIndex(where: { $0.filterType == FilterTypeEnum.COUNTRY })
        if(index != nil) {
            filterTags.remove(at: index!)
        }
        filterTags.append(FilterTags().withName(name: poJo.name ?? "", filterType: FilterTypeEnum.COUNTRY))
        afterFilterChange(filterTags)
    }

    var body: some View {
        CollectionListView<VStack, Countries>(
            state: self.$viewModel.poJoListState,
            requestPull: {
                viewModel.loadPoJoList(filter: "")
            },
            requestReload: {
                viewModel.loadPoJoList(filter: "")
            },
            requestSearch: { query in
                viewModel.loadPoJoList(filter: query)
            },
            builder: { poJo, _ in
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            Text(poJo.name ?? "")
                                .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        }.frame(width: geometry.size.width * 0.9, alignment: .leading)
                            .foregroundColor(.primary)
                            .background(Color(UIColor.systemBackground).opacity(0.95))
                            .onTapGesture {
                            submitPoJo(poJo: poJo)
                        }
                    }
                }
            })
    }

}
