//
//  ChipsContent.swift
//  radiostore
//
//  Created by adham khwaldeh on 14/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct ChipsContent: View {

    @Binding var filterTags: [FilterTags]


    var body: some View {
//        var width = CGFloat.zero
//        var height = CGFloat.zero
        return GeometryReader { geo in
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    ForEach(filterTags) { chipsData in
                        Chips(systemImage: "multiply",
                              title: chipsData.name,
                              filterTags: $filterTags)//chipsData.isSelected)
                        .padding(.all, 5)
//                        .alignmentGuide(.leading) { dimension in
//                        if (abs(width - dimension.width) > geo.size.width) {
//                            width = 0
//                            height -= dimension.height
//                        }
//
//                        let result = width
////                        if chipsData.id == viewModel.dataObject.last!.id {
////                            width = 0
////                        } else {
//                        width -= dimension.width
////                        }
//                        return result
//                    }
//                        .alignmentGuide(.top) { dimension in
//                        let result = height
////                        if chipsData.id == viewModel.dataObject.last!.id {
////                        height = 0
////                        }
//                        height = 0//1111
//                        return result
//                    }
                    }
                }
            }
//            ZStack(alignment: .topLeading, content: {
//                ForEach(filterTags) { chipsData in
//                    Chips(systemImage: "multiply",
//                          title: chipsData.name,
//                          filterTags: $filterTags)//chipsData.isSelected)
//                    .padding(.all, 5)
////                        .alignmentGuide(.leading) { dimension in
////                        if (abs(width - dimension.width) > geo.size.width) {
////                            width = 0
////                            height -= dimension.height
////                        }
////
////                        let result = width
//////                        if chipsData.id == viewModel.dataObject.last!.id {
//////                            width = 0
//////                        } else {
////                        width -= dimension.width
//////                        }
////                        return result
////                    }
////                        .alignmentGuide(.top) { dimension in
////                        let result = height
//////                        if chipsData.id == viewModel.dataObject.last!.id {
//////                        height = 0
//////                        }
////                        height = 0//1111
////                        return result
////                    }
//                }
//            })
        }.padding(.all, 10)
    }

}
