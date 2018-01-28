//
//  _0180117_JS_NYCSchoolsTests.swift
//  20180117-JS-NYCSchoolsTests
//
//  Created by jeff sanok on 1/17/18.
//  Copyright © 2018 jeffsanok. All rights reserved.
//

import XCTest
@testable import _0180117_JS_NYCSchools

class _0180117_JS_NYCSchoolsTests: XCTestCase {

    var resData:[SchoolInfo]?
    var resDetailData:[SATData]?
    var dbn:String?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSchoolsViewControllerLoad() {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        XCTAssertNotNil(sb, "Could not instantiate story board")
        guard let vc = sb.instantiateViewController(withIdentifier: "schoolsVC") as?
        SchoolsViewController else {
            XCTAssert(false, "Could not instantiate SchoolsViewController")
            return
        }
        XCTAssert(vc.viewModel.schools.count == 0, "schools array should be zero")
    }

    func testGetSchoolListData() {
        
        SchoolData.getSchoolData { (data, error) in
            self.resData = data
        }
        let predicate = NSPredicate(format: "resData != nil")
        let exp = expectation(for: predicate, evaluatedWith: self, handler:nil)
        let res = XCTWaiter.wait(for: [exp], timeout:10.0)
        if(res == XCTWaiter.Result.completed){
            XCTAssertNotNil(resData, "No data received from the server")
        }
    }
    
    func testDetailsViewControllerLoad() {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        XCTAssertNotNil(sb, "Could not instantiate story board")
        guard let vc = sb.instantiateViewController(withIdentifier: "detailsVC") as?
        DetailsViewController else {
            XCTAssert(false, "Could not instantiate DetailsViewController")
            return
        }
        XCTAssert(vc.viewModel.satData.count == 0, "SAT data array should be zero")
    }
    
    func testGetSATData() {
        
        SATDetailsData.getSATScoreDetails(dbn: self.dbn) { (data , error) in
            self.resDetailData = data
        }
        let predicate = NSPredicate(format: "resDetailData != nil")
        let exp = expectation(for: predicate, evaluatedWith: self, handler:nil)
        let res = XCTWaiter.wait(for: [exp], timeout:10.0)
        if(res == XCTWaiter.Result.completed){
            XCTAssertNotNil(resDetailData, "No SAT data received from the server")
        }
    }
    
}
