//
//  LanguageScreenView.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

//import Foundation
import SwiftUI

struct LanguageScreenView: View {

    @ObservedObject var viewModel = LanguageViewModel()

    @Binding private var filterTags: [FilterTags]

    private var afterFilterChange: ([FilterTags]) -> Void

    init(filterTags: Binding<[FilterTags]>, afterFilterChange: @escaping ([FilterTags]) -> Void) {
        self._filterTags = filterTags
        self.afterFilterChange = afterFilterChange
        self.viewModel.loadPoJoList(filter: "")
    }

    private func submitPoJo(poJo: Languages) {
        let index = filterTags.firstIndex(where: { $0.filterType == FilterTypeEnum.LANGUAGE })
        if(index != nil) {
            filterTags.remove(at: index!)
        }
        filterTags.append(FilterTags().withName(name: poJo.name ?? "", filterType: FilterTypeEnum.LANGUAGE))
        afterFilterChange(filterTags)
    }

    var body: some View {
        VStack {
            CollectionListView<VStack, Languages>(
                state: self.$viewModel.poJoListState,
                requestPull: {
                    self.viewModel.loadPoJoList(filter: "")
                },
                requestReload: {
                    self.viewModel.loadPoJoList(filter: "")
                },
                requestSearch: { query in
                    self.viewModel.loadPoJoList(filter: query)
                },
                builder: { poJo, _ in
                    VStack {
                        GeometryReader { geometry in
                            VStack {
                                Text(poJo.name ?? "")
                                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
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

}
