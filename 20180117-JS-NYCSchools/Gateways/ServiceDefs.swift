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

struct APISettings: Decodable {
    var token: String
    var headerKey: String
}

extension URL {

    var apiSettings:APISettings? {

        if let filepath = Bundle.main.path(forResource: "api", ofType: "plist"){
            let settingsURL: URL = URL(fileURLWithPath: filepath)
            var settings: APISettings?

            if let data = try? Data(contentsOf: settingsURL) {
              let decoder = PropertyListDecoder()
              settings = try? decoder.decode(APISettings.self, from: data)
            }
            return settings
        }
        return nil
    }

}

enum EndPoint:String {
    case SchoolList = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    case SATScoreDetails = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
}





