//
//  Constants.swift/Users/adhamkhwaldeh/Data/Android/Projects/MyProjects/TvApp/protvappios/protv/protv/Info.plist
//  protv
//
//  Created by adham khwaldeh on 23/12/19.
//  Copyright © 2019 adham khwaldeh. All rights reserved.
//

import Foundation

struct Constants {

    //The API's base URL
//    static let baseUrl = "http://nl1.api.radio-browser.info/"
    static let baseUrl = "https://de1.api.radio-browser.info/"

    //The parameters (Queries) that we're gonna use
    struct Parameters {
//        static let userId = "userId"

    }

    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }

}
