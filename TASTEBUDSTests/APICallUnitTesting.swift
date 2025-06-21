//
//  APICallUnitTesting.swift
//  TASTEBUDS
//
//  Created by Aditya on 21/06/25.
//

import XCTest

final class APICallUnitTesting: XCTestCase {
    
    // API call complete within 0.1 sec?
    func testAPICallUsingExpectation() {
        let expectation = XCTestExpectation(description: "call a network async")
        let sut = APIManager.sharedInstance
        sut.makeApiCall(serviceType: .getMeals) {
             response in
            expectation.fulfill()
            XCTAssertNotNil(response)
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    // API call complete within 1 sec?
    func testAPICallUsingExpectation2() {
        let expectation = XCTestExpectation(description: "call a network async")
        let sut = APIManager.sharedInstance
        sut.makeApiCall(serviceType: .getMeals) {
            response in
            expectation.fulfill()
            XCTAssertNotNil(response)
        }
        wait(for: [expectation], timeout: 1)
    }
}
