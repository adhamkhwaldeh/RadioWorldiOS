//
//  BaseCollectionViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 30/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class BaseCollectionViewModel<T>: BaseViewModel {

    @Published var poJoListState: NetworkState<[T]> = NetworkState.loading

    func getEndpoint(filter: String) -> Future<[T], Error> {
        preconditionFailure("This method must be overridden")
    }

    var cancellableTask: AnyCancellable? = nil

    func loadPoJoList(filter: String) {
        poJoListState = NetworkState.loading
        cancellableTask?.cancel()
        cancellableTask = getEndpoint(filter: filter).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.poJoListState = NetworkState.error(error.localizedDescription)
            }
        }, receiveValue: { poJoList in
            self.poJoListState = NetworkState.content(poJoList)
        })
    }


}
