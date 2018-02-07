//
//  SchoolData.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation


class SchoolData  {
    
    static func getSchoolData(completion: @escaping ([SchoolInfo], Error?) -> ()) {
    let sessionConfig = URLSessionConfiguration.default

        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)

        guard var URL = URL(string: EndPoint.SchoolList.rawValue) else {return}
        
        let URLParams = [
            "$select": "dbn,school_name",
        ]
        URL = URL.appendingQueryParameters(URLParams)
        var request = URLRequest(url: URL)
        request.httpMethod = "GET"
        request.addValue((URL.apiSettings?.token)!, forHTTPHeaderField: (URL.apiSettings?.headerKey)!)
        
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                // success
                if let response = response as? HTTPURLResponse {
                    print("URL Session response status code HTTP \(response.statusCode)")
                }
                guard let data = data else { return }
                do {
                
                    let schools:[SchoolInfo] = try JSONDecoder().decode([SchoolInfo].self, from: data)
                    if(schools.count > 0) {
                            DispatchQueue.main.async {
                            completion(schools, error)
                        }
                    }
                    else
                    {
                        print( "No School Records")
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
