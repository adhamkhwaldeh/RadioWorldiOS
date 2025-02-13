//
//  CodableExtensions.swift
//  radiostore
//
//  Created by adham on 12/7/20.
//  Copyright © 2020 adham. All rights reserved.
//

import Foundation

extension Encodable {

    var dict : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
    
    
    var jsonStringParams: String {
        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(self), let result = String(data: data, encoding: .utf8) else {
            return "{}"
        }

        return result
    }
    
    var queryDictionary: [String: String]? {

        var queryStrings = [String: String]()
        let s = self.jsonStringParams.replacingOccurrences(of: "\"", with:"") 
        for pair in s.components(separatedBy: "&") {
         
               let key = pair.components(separatedBy: "=")[0]

               let value = pair
                   .components(separatedBy:"=")[1]
                   .replacingOccurrences(of: "+", with: " ")
                   .removingPercentEncoding ?? ""

               queryStrings[key] = value
           }
           return queryStrings
       }

    
}

