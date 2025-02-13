//
//  StationViewModel.swift
//  radiostore
//
//  Created by adham khwaldeh on 19/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class StationViewModel: BaseViewModel, ObservableObject, Identifiable {

    @Published var filterTags: [FilterTags] = []

    @Published var stationsHomeState: NetworkState<[Stations]> = NetworkState.loading
    var homeCancellableTask: AnyCancellable? = nil

    func loadStations(search: String, filterby: [FilterTags]) {
        stationsHomeState = NetworkState.loading
        homeCancellableTask?.cancel()
        homeCancellableTask = appClient.getFilterStationsList(searchterm: search, filterby: filterby, offset: 0, limit: 1000)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.stationsHomeState = NetworkState.error(error.localizedDescription)
            }
        }, receiveValue: { stationList in
//                DispatchQueue.main.async {
            self.stationsHomeState = NetworkState.content(stationList)
//                }
        })
    }



    @Published var stationsTrendState: NetworkState<[Stations]> = NetworkState.loading
    var trendCancellableTask: AnyCancellable? = nil

    func loadTrendStations(trendTabEnum: TrendTabEnum, search: String) {
        stationsTrendState = NetworkState.loading
        trendCancellableTask?.cancel()

        var request: Future<[Stations], Error>

        switch(trendTabEnum) {
        case .top_click:
            request = appClient.getTopClickStationList(rowcount: "100")
            break
        case .top_vote:
            request = appClient.getTopVoteStationList(rowcount: "100")
            break
        case .last_change:
            request = appClient.getLastChangeStationList(rowcount: "100")
            break
        case .last_visited:
            request = appClient.getLastClickStationList(rowcount: "100")
            break
        }

        trendCancellableTask = request.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.stationsTrendState = NetworkState.error(error.localizedDescription)
            }
        }, receiveValue: { stationList in
            let newList = search.isEmpty ? stationList : stationList.filter { $0.name?.contains(search) ?? true }
            self.stationsTrendState = NetworkState.content(newList)
        })
    }



    @Published var stationPlayableState: NetworkState<PlayableStation> = NetworkState.loading
    var stationPlayableCancellableTask: AnyCancellable? = nil

    func loadStationPlayable(station: Stations) {
        stationPlayableState = NetworkState.loading
        stationPlayableCancellableTask?.cancel()
        stationPlayableCancellableTask = appClient.getCheckPlayableStationsList(stationid: station.stationuuid!).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.stationPlayableState = NetworkState.error(error.localizedDescription)
            }
        }, receiveValue: { playableStation in
            self.stationPlayableState = NetworkState.content(playableStation)
        })
    }



    deinit {
        homeCancellableTask = nil
        homeCancellableTask = nil
        trendCancellableTask = nil
    }


//    @Published var stationsSearchState: NetworkState<[Stations]> = NetworkState.loading
//    var searchCancellableTask: AnyCancellable? = nil
//
//    func loadStationSearch(search: String) {
//        stationsSearchState = NetworkState.loading
//        searchCancellableTask?.cancel()
//        searchCancellableTask = appClient.getStationsList(searchterm: search).sink(receiveCompletion: { completion in
//            switch completion {
//            case .finished:
//                break
//            case .failure(let error):
//                self.stationsSearchState = NetworkState.error(error.localizedDescription)
//            }
//        }, receiveValue: { stationList in
//            self.stationsSearchState = NetworkState.content(stationList)
//        })
//    }


    /* UrlSession started */
//        self.cancellableTask?.cancel()
//
//        stationsState = NetworkState.loading
//
//        guard let url = URL(string: "http://nl1.api.radio-browser.info/json/stations/topvote/100") else { return }
////        //cancel last subscription to prevent race condition
//        self.cancellableTask = URLSession.shared
//            .dataTaskPublisher(for: url)
//            .receive(on: DispatchQueue.main)
////            .tryMap ({ data, response in
////                        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
////                            throw APIError.unknown
////                        }
////                        return data
////                    })
////                    .mapError ({ error in
////                        if let error = error as? APIError {
////                            return error
////                        } else {
////                            return APIError.apiError(reason: error.localizedDescription)
////                        }
////                    })
////            .map(\.data) //extract Data() from tuple
//            .map { $0.data }
//            .decode(type: [Stations].self, decoder: JSONDecoder())
//            .sink { (completion) in
//                switch completion {
//                        case .finished:
//                            break
//                        case .failure(let error):
//                            self.stationsState = NetworkState.error(error.localizedDescription)
//                }
//            } receiveValue: { [unowned self] (stationList) in
//                self.stationsState = NetworkState.content(stationList)
//            }
    /* UrlSession started */




}
