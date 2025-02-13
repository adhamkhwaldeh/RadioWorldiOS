//
//  ApiRouter.swift
//  protv
//
//  Created by adham khwaldeh on 23/12/19.
//  Copyright © 2019 adham khwaldeh. All rights reserved.
//

import Foundation
import Alamofire
//import RxSwift

enum ApiRouter: URLRequestConvertible {

    /* Trend actions started */
    case getTopClickStationList(rowcount: String)

    case getTopVotesStationList(rowcount: String)

    case getLastClickStationList(rowcount: String)

    case getLastChangeStationList(rowcount: String)
    /* Trend actions ended */

    /*Tags action started*/
    case getCountryList(filter: String)

    case getStateList(filter: String)

    case getStateWithCountryList(country: String, filter: String)

    case getLanguageList(filter: String)

    case getTagList(filter: String)
    /*Tags action ended*/


    /* Use Stations Filtration enum */
    case getFilterStationsList(searchterm: String, filterby: [FilterTags], offset: Int, limit: Int)

    case getStationsList(searchterm: String)

    case getCheckPlayableStationsList(stationid: String)
    /* Use Stations Filtration enum */



    //MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getTopClickStationList:
            return .get
        case .getTopVotesStationList:
            return .get
        case .getLastClickStationList:
            return .get
        case .getLastChangeStationList:
            return .get
        case .getCountryList:
            return .get
        case .getStateList:
            return .get
        case .getStateWithCountryList:
            return .get
        case .getLanguageList:
            return .get
        case .getTagList:
            return .get
        case .getFilterStationsList:
            return .get
        case .getStationsList:
            return .get
        case .getCheckPlayableStationsList:
            return .get
        }
    }

    //MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var realPostObject: Encodable? {
        switch self {
        case .getTopClickStationList(let rowcount):
            return nil// rowcount
        case .getTopVotesStationList(let rowcount):
            return  nil//rowcount
        case .getLastClickStationList(let rowcount):
            return nil//rowcount
        case .getLastChangeStationList(let rowcount):
            return nil//rowcount
        case .getCountryList(let filter):
            return nil //filter
        case .getStateList(let filter):
            return nil//filter
        case .getStateWithCountryList(let country, let filter):
            return nil //country + filter
        case .getLanguageList(let filter):
            return nil//filter
        case .getTagList(let filter):
            return nil // filter
        case .getFilterStationsList(let searchterm, let filterby, let offset, let limit):
        
            var link = "offset=" + String(offset) + "&limit=" + String(limit)
//
            if(!searchterm.isEmpty){
                link += "&name=" + searchterm
            }
//            var link="name=" + searchterm + "&offset=" + String(offset) + "&limit=" + String(limit)

            filterby.filter { $0.filterType != FilterTypeEnum.TAG }.forEach { filterItem in
                link += "&" + filterItem.filterType.rawValue.lowercased() + "=" + filterItem.name
            }
            let tags: String = filterby.filter { $0.filterType == FilterTypeEnum.TAG }.reduce(into: String()) { (result, item) in
                result += item.name + ","
            }
            if(!tags.isEmpty) {
                link += "&tag=" + tags.replacingOccurrences(of: "#", with: "%23")
            }
            return link//searchterm //filterby +
        case .getStationsList(let searchterm):
            return nil // searchterm
        case .getCheckPlayableStationsList(let stationid):
            return nil // stationid
        }
    }

    //MARK: - Path
    //The path is the part following the base url
    private var path: String {
        switch self {
        case .getTopClickStationList(let rowcount):
            return "json/stations/topclick/" + rowcount
        case .getTopVotesStationList(let rowcount):
            return "json/stations/topvote/" + rowcount
        case .getLastClickStationList(let rowcount):
            return "json/stations/lastclick/" + rowcount
        case .getLastChangeStationList(let rowcount):
            return "json/stations/lastchange/" + rowcount
        case .getCountryList(let filter):
            return "json/countries/" + filter
        case .getStateList(let filter):
            return "json/states/" + filter
        case .getStateWithCountryList(let country, let filter):
            return "json/states/" + country + "/" + filter
        case .getLanguageList(let filter):
            return "json/languages/" + filter.lowercased()
        case .getTagList(let filter):
            return "json/tags/" + filter.lowercased()
        case .getFilterStationsList(let searchterm, let filterby, let offset, let limit):
//            var link = "json/stations/search?name=" + searchterm //+ filterby + "&"
//            + "&offset=" + String(offset) + "&limit=" + String(limit)
//
//            filterby.filter { $0.filterType != FilterTypeEnum.TAG }.forEach { filterItem in
//                link += "&" + filterItem.filterType.rawValue.lowercased() + "=" + filterItem.name
//            }
//            let tags: String = filterby.filter { $0.filterType == FilterTypeEnum.TAG }.reduce(into: String()) { (result, item) in
//                result += item.name + ","
//            }
//            if(!tags.isEmpty) {
//                link += "&tag=" + tags.replacingOccurrences(of: "#", with: "%23")
//            }
//            return link
            var link = "json/stations/search"
            return link
        case .getStationsList(let searchterm):
            return "json/stations/search?name=" + searchterm
        case .getCheckPlayableStationsList(let stationid):
            return "v2/json/url/" + stationid
        }
    }

    //MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseUrl.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        //Http method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)

//        if(GeneralRepository.getUserToken() != nil) {
//            urlRequest.setValue("Bearer " + GeneralRepository.getUserToken()!,
//                forHTTPHeaderField: Constants.HttpHeaderField.authentication.rawValue)
//        }

        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            case .post:
                return URLEncoding.httpBody
            default:
                return JSONEncoding.default
            }
        }()

//        let dic :Dictionary<String,String> = ["aa":"","bb":""]
//        let postString = "{\"email\":\"adhamkhwaldeh@gmail.com\",\"password\":\"aZ0943915633$\"}";
//        // Set HTTP Request Body
//        urlRequest.httpBody = postString.data(using: String.Encoding.utf8);

        return assignParameters(urlRequest: urlRequest, encoding: encoding)


//            try! JSONSerialization.data(withJSONObject: parameters  ,options: [])
//        if(encoding = URLEncoding.default){
        //

//            AF.request( url.appendingPathComponent(path),method: method,parameters: parameters,encoding: encoding)
//        }else{
//            let pjson = parameters.toJSONString(prettyPrint: false)
//            let data = (pjson?.data(using: .utf8))! as Data
//
//            request.httpBody = data
//            urlRequest.httpBody = JSONEncoder.encode(parameters)
//        }
//


    }


    private func assignParameters (urlRequest: URLRequest, encoding: ParameterEncoding) -> URLRequest {
        let newRequest = urlRequest
//        let encoder = JSONEncoder()
        if(method == .post) {
//            if(realPostObject is LoginPostModel) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! LoginPostModel)
//            } else if(realPostObject is RefreshTokenPostModel) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! RefreshTokenPostModel)
//            } else if(realPostObject is ChannelFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! ChannelFilter)
//            } else if(realPostObject is GroupFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! GroupFilter)
//            } else if(realPostObject is PackageFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! PackageFilter)
//            } else if(realPostObject is MovieFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! MovieFilter)
//            } else if(realPostObject is MovieGroupFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! MovieGroupFilter)
//            } else if(realPostObject is RadioFilter) {
//                newRequest.httpBody = try? encoder.encode(realPostObject as! RadioFilter)
//            }
            return newRequest
        } else {
            let s = realPostObject
//            let dt = realPostObject?.dict
            let q = realPostObject?.queryDictionary
            return try!  encoding.encode(urlRequest, with: realPostObject?.queryDictionary)
        }
    }

}

