//
//  Chips.swift
//  radiostore
//
//  Created by adham khwaldeh on 14/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct Chips: View {

    let systemImage: String

    let title: String

    @Binding var filterTags: [FilterTags]

    var body: some View {
        HStack {
            Image.init(systemName: systemImage).font(.subheadline)
            Text(title).font(.subheadline).lineLimit(1)
        }.padding(.horizontal, 8).padding(.vertical, 4)
//            .foregroundColor(isSelected ? .white : .blue)
//            .background(isSelected ? Color.blue : Color.white)
        .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(40)
            .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.blue, lineWidth: 1.0)
        ).onTapGesture {
            let index = filterTags.firstIndex(where: { $0.name == title })
            if(index != nil) {
                filterTags.remove(at: index!)
            }
//            isSelected.toggle()
        }
    }

}
