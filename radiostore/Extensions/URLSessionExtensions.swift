//
//  URLSessionExtensions.swift
//  radiostore
//
//  Created by adham khwaldeh on 20/12/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation
import Combine


extension URLSession
{
    func fetchJSONExt<T: Codable>(for request: URLRequest) -> AnyPublisher<T, Error>
    {
        return dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


//struct Resource<T: Codable>
//{
//    let  request: URLRequest
//}
