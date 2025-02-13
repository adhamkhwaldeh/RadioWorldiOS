//
//  TagsScreenView.swift
//  radiostore
//
//  Created by adham khwaldeh on 31/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct TagsScreenView: View {

    @ObservedObject var viewModel = TagViewModel()

    @Binding var filterTags: [FilterTags]

    private var afterFilterChange: ([FilterTags]) -> Void

    @State private var searchText: String = ""

    private func loadData() {
        self.viewModel.loadPoJoList(filter: searchText)
    }

    init(filterTags: Binding<[FilterTags]>, afterFilterChange: @escaping ([FilterTags]) -> Void) {
        self._filterTags = filterTags
        self.afterFilterChange = afterFilterChange
        loadData()
    }

    private func submitPoJo(name: String?) {
        filterTags.append(FilterTags().withName(name: name ?? "", filterType: FilterTypeEnum.TAG))
        afterFilterChange(filterTags)
    }

    var body: some View {

        VStack {
            CollectionListView<VStack, Tags>(
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

                                submitPoJo(name: poJo.name)

                            }
                        }

                    }
                })
        }

//        NetworkStateListView(state: $viewModel.poJoListState, requestPull: loadData, requestReload: loadData) { poJoList in
//
//            VStack {
//
//                SearchBarView(searchText: $searchText) {
//                    loadData()
//                }.padding(.vertical)
//
//                if(poJoList.isEmpty) {
//                    HStack {
//                        Text(Translation.No_data_found)
//                    }
//                } else {
//                    ScrollView {
//                        FlexibleView(//<[Tags], VStack>
//                        data: poJoList.map { $0.name ?? "" }.prefix(100), //, //originalItems,
//                        spacing: 8, alignment: HorizontalAlignment.leading
//                        ) { item in
//                            VStack {
//                                Text(verbatim: item)
//                                    .padding(8)
//                                    .background(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .fill(Color.gray.opacity(0.2))
//                                ).onTapGesture {
//                                    submitPoJo(name: item)
//                                }
//                            }
//                        }.padding()
//                    }
//                }
//
//            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
//
//        }
//            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)

    }


}
