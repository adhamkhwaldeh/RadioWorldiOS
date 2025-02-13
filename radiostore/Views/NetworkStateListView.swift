//
//  NetworkStateListView.swift
//  radiostore
//
//  Created by adham khwaldeh on 16/1/21.
//  Copyright © 2021 adham. All rights reserved.
//

import Foundation
import SwiftUI

struct NetworkStateListView<Content: View, T: Identifiable>: View {

    var requestPull: () -> Void

    var requestReload: () -> Void

    var destination: ([T]) -> Content

    @Binding var poJoListState: NetworkState<[T]>

    init(state: Binding<NetworkState<[T]>>, requestPull: @escaping () -> Void,
         requestReload: @escaping () -> Void, @ViewBuilder builder: @escaping ([T]) -> Content) {
        self._poJoListState = state
        self.requestPull = requestPull
        self.requestReload = requestReload
        self.destination = builder
    }

    var body: some View {

        HStack {
            switch(poJoListState) {
            case NetworkState.loading:
                HStack {
                    ActivityIndicator(isAnimating: $poJoListState.isLoading, style: UIActivityIndicatorView.Style.large)

                    Text(Translation.Loading).font(.title3).padding()
                }.frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            case NetworkState.loadingDismiss:
                HStack {
                    Text(Translation.Loaded_Successfully)
                }.frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            case NetworkState.error(_): //error(let error):
                VStack {
                    Text(Translation.Network_not_available).font(.title)
                        .padding(.bottom, 20)
                        .padding(.top, 120)
                    Button(action: {
                        requestReload()
                    }) {
                        HStack {
                            Text(Translation.Retry)
//                                .fontWeight(.)
//                                .font(.)
                        }.frame(width: 230)
                    }.buttonStyle(GradientButtonStyle()).frame(width: 200)
                }.frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            case NetworkState.content(let poJoList):
                destination(poJoList)
            }
        }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)

    }

}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.foregroundColor(Color.white).padding(.horizontal, 8)
            .padding(.top, 12).padding(.bottom, 12)
            .background(LinearGradient(gradient: Gradient(colors: [.blue, Color.blue]),
                                       startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
