//
//  SATData.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation

struct SATData : Decodable {

    let dbn:String
    let school_name:String
    let num_of_sat_test_takers:String
    let sat_critical_reading_avg_score:String
    let sat_math_avg_score:String
    let sat_writing_avg_score:String

}
