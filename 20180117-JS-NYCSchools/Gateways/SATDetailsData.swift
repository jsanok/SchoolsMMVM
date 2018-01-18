//
//  SATDetailsData.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation

class SATDetailsData  {

    static func getSATScoreDetails(dbn:String?, completion: @escaping ([SATData], Error?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default

        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard var URL = URL(string: EndPoint.SATScoreDetails.rawValue) else {return}
        
        guard let dbn = dbn else {return}
        
        let URLParams = [
            "dbn": dbn,
        ]
        
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"

        // header
        request.addValue(API.token.rawValue, forHTTPHeaderField: API.headerKey.rawValue)

        //task
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // Success
                if let response = response as? HTTPURLResponse {
                    print("URL Session response status code HTTP \(response.statusCode)")
                }
                guard let data = data else { return }
                do {
                    let satData:[SATData] = try JSONDecoder().decode([SATData].self, from: data)

                        DispatchQueue.main.async {
                            completion(satData, error)
                        }
                    }
                    catch {
                        print("JSON error")
                    }
            }
            else {
                // failure
                print("URL Session Task Failed %@", error!.localizedDescription);
            }
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

