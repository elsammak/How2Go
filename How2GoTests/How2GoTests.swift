//
//  How2GoTests.swift
//  How2GoTests
//
//  Created by Mohammed Elsammak on 1/27/17.
//  Copyright © 2017 How2Go. All rights reserved.
//

import XCTest
@testable import How2Go

class How2GoTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testExample() {
        let apiClient = APIClient()
        
        let asyncApiCallExpectation = self.expectation(description: "asyncApiCallExpectation")
        
        apiClient.getRoutes { (routesArray, error) in
            
            XCTAssertNotNil(routesArray)
            XCTAssertEqual(routesArray?.count, 9, "Total number of items = \(routesArray?.count)")
            guard let array = routesArray else { return }
            let firstRoute: Route = array[0]
            XCTAssertEqual(firstRoute.type, "public_transport", "First route type: \(firstRoute.type)")
            XCTAssertNil(error)
            
            asyncApiCallExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }

    }

}
