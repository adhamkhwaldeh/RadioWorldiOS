//
//  ApiClient.swift
//  protv
//
//  Created by adham khwaldeh on 23/12/19.
//  Copyright © 2019 adham khwaldeh. All rights reserved.
//

import Alamofire
//import RxSwift
import Combine

class ApiClient {

    /*Trend action started*/
    func getTopClickStationList(rowcount: String) -> Future<[Stations], Error> {
        return requestUrlSession(urlConvertible: ApiRouter.getTopClickStationList(rowcount: rowcount))
    }

    func getTopVoteStationList(rowcount: String) -> Future<[Stations], Error> {
        return request(urlConvertible: ApiRouter.getTopVotesStationList(rowcount: rowcount))
    }

    func getLastClickStationList(rowcount: String) -> Future<[Stations], Error> {
        return request(urlConvertible: ApiRouter.getLastClickStationList(rowcount: rowcount))
    }

    func getLastChangeStationList(rowcount: String) -> Future<[Stations], Error> {
        return request(urlConvertible: ApiRouter.getLastChangeStationList(rowcount: rowcount))
    }
    /*Trend action ended*/


    /*Tags actions started*/
    func getCountryList(filter: String) -> Future<[Countries], Error> {
        return request(urlConvertible: ApiRouter.getCountryList(filter: filter))
    }

    func getStateList(filter: String) -> Future<[States], Error> {
        return request(urlConvertible: ApiRouter.getStateList(filter: filter))
    }

    func getStatesWithCountryList(country: String, filter: String) -> Future<[States], Error> {
        return request(urlConvertible: ApiRouter.getStateWithCountryList(country: country, filter: filter))
    }

    func getLanguageList(filter: String) -> Future<[Languages], Error> {
        return request(urlConvertible: ApiRouter.getLanguageList(filter: filter))
    }

    func getTagList(filter: String) -> Future<[Tags], Error> {
        return request(urlConvertible: ApiRouter.getTagList(filter: filter))
    }
    /*Tags actions ended*/

    /* Use Stations Filtration enum */
    func getFilterStationsList(searchterm: String, filterby: [FilterTags], offset: Int, limit: Int) -> Future<[Stations], Error> {
        return request(urlConvertible: ApiRouter.getFilterStationsList(searchterm: searchterm,
                                                                       filterby: filterby, offset: offset, limit: limit))
    }

    func getStationsList(searchterm: String) -> Future<[Stations], Error> {
        return request(urlConvertible: ApiRouter.getStationsList(searchterm: searchterm))
    }

    func getCheckPlayableStationsList(stationid: String) -> Future<PlayableStation, Error> {
        return request(urlConvertible: ApiRouter.getCheckPlayableStationsList(stationid: stationid))
    }
    /* Use Stations Filtration enum */


//-------------------------------------------------------------------------------------------------
    //MARK: - The request function to get results in an Observable
    //_

//    private func request<T: Codable> (urlConvertible: URLRequestConvertible) -> Observable<T> {
//        //Create an RxSwift observable, which will be the one to call the request when subscribed to
//        return Observable<T>.create { observer in
//
//
//            //Trigger the HttpRequest using AlamoFire (AF)
//            let request = AF.request(urlConvertible)
//            request.responseDecodable { (response: AFDataResponse<T>) in
//                //Check the result from Alamofire's response and check if it's a success or a failure
//                switch response.result {
//                case .success(let value):
//                    //Everything is fine, return the value in onNext
//                    observer.onNext(value)
//                    observer.onCompleted()
//                case .failure(let error):
//                    //Something went wrong, switch on the status code and return the error
//                    switch response.response?.statusCode {
//                    case 403:
//                        observer.onError(ApiError.forbidden)
//                    case 404:
//                        observer.onError(ApiError.notFound)
//                    case 409:
//                        observer.onError(ApiError.conflict)
//                    case 500:
//                        observer.onError(ApiError.internalServerError)
//                    default:
//                        observer.onError(error)
//                    }
//                }
//            }
//
//            //Finally, we return a disposable to stop the request
//            return Disposables.create {
//                request.cancel()
//            }
//        }
//    }


    func request<T: Decodable, E: Error>(
        urlConvertible: URLRequestConvertible
    ) -> Future<T, E> {
        return Future({ promise in
            AF.request(
                urlConvertible
            ).responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    promise(.success(value))
                case .failure(let error):
                    promise(.failure(
                        NSError(domain: error.destinationURL?.absoluteString ?? "", code: error.responseCode ?? 0) as! E
                    )
                    )
                }
            })
        })
    }

    func requestUrlSession<T: Codable, E: Error>(
        urlConvertible: URLRequestConvertible
    ) -> Future<T, E> {
        return Future({ promise in
            var ticket: AnyCancellable? = nil
            ticket = URLSession.DataTaskPublisher(request: urlConvertible.urlRequest!, session: .shared)
                .tryMap {
                data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw ApiError.unknown
                }
                return data
            }
                .mapError({ error in
                return error
            })
                .decode(type: T.self, decoder: JSONDecoder()).eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    ticket?.cancel()
                    ticket = nil
                    promise(.failure(error as! E))
                    break
                }
            }, receiveValue: { data in
                ticket?.cancel()
                ticket = nil
                promise(.success(data))
            })

        }) }


//                    .sink { error in
//                        promise(.failure(error))
//                    } receiveValue: { response in
//
//                    }


//                    .dataTask(with: urlConvertible.urlRequest!, completionHandler: { (data: Data?, response :URLResponse?, error :Error?) in
//                    promise(.success(data))
    //}dataTaskPublisher(for: urlConvertible.urlRequest!)

//                .responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<T, AFError>) in
//                       switch response.result {
//                           case .success(let value):
//                               promise(.success(value))
//                           case .failure(let error):
//                               promise(.failure(
//                                   NSError(domain: error.destinationURL?.absoluteString ?? "", code: error.responseCode ?? 0) as! E
//                                   )
//                           )
//                       }
//                   })
//               })
//           }

}
