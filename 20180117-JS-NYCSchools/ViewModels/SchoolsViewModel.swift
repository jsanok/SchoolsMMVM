//
//  SchoolsViewModel.swift
//  20180117-JS-NYCSchools
//
//  Created by jeff sanok on 1/26/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import Foundation

class SchoolsViewModel {

    //var filteredSchools:DynamicBox<[SchoolInfo]> = DynamicBox([SchoolInfo]())
    var filteredSchools = [SchoolInfo]()
    var schools = [SchoolInfo]()
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        self.filteredSchools = self.schools.filter({( school : SchoolInfo) -> Bool in
        return school.school_name.lowercased().contains(searchText.lowercased())
        })
    }
    
}


