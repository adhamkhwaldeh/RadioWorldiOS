//
//  ApiError.swift
//  protv
//
//  Created by adham khwaldeh on 23/12/19.
//  Copyright © 2019 adham khwaldeh. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case conflict               //Status code 409
    case internalServerError    //Status code 500
    case unknown
}
