//
//  ServiceDefs.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation

protocol URLQueryParameterStringConvertible {
    var queryParameters: String { get }
}

extension Dictionary : URLQueryParameterStringConvertible {
    
     //computed property returns a query parameters string from the given Dictionary
     //if the input is {"day":"Tuesday","month":"January"}, the output
     //string will be @"day=Tuesday&month=January"
    
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}

extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, String>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)! //this unwrap is okay because we could not be here without a valid URL
    }
}

enum API:String {
    case token = "pJlmGqS4VkIDpZlF3Y23bokV9"
    case headerKey = "X-App-Token"
}

enum EndPoint:String {
    case SchoolList = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    case SATScoreDetails = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
}





