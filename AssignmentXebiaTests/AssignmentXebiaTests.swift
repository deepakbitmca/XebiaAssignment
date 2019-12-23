//
//  AssignmentXebiaTests.swift
//  AssignmentXebiaTests
//
//  Created by Deepak Chauhan on 12/22/19.
//  Copyright © 2019 Deepak Chauhan. All rights reserved.
//

import XCTest
@testable import AssignmentXebia

class AssignmentXebiaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    /// test case for record async api
    func testRecordListApi(){
        let serviceName = "api-key=6eKJOzCYZkuFsMi6rvjXjRY7WcbrGaMf"
        
        let exp = expectation(description: "callback closure call")
        
        ConnectionManager.sharedInstance.getDataRequest(inputParameter: "", serviceName: serviceName, httpMethod: "GET", dataPost: nil, completionHandler: { (result , status:Bool) -> Void in
            exp.fulfill()
            if (result != nil && status) {
                XCTAssertEqual(status, true)
            }else{
               XCTFail("Bad Request")
            }
        }, faliour: { (errorMessage , status:Bool) -> Void in
            let message  = errorMessage as String? ?? ""
            XCTFail(message)
        })
        
        waitForExpectations(timeout: 200) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
}
