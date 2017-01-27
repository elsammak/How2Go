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

    func testRoutesArray() {
        let apiClient = APIClient()
        
        let asyncApiCallExpectation = self.expectation(description: "asyncApiCallExpectation")
        
        apiClient.getRoutes { (routesArray, error) in
            
            XCTAssertNotNil(routesArray)
            XCTAssertEqual(routesArray?.count, 9, "Total number of items = \(routesArray?.count)")
            guard let array = routesArray else { return }
        
            let seventhRoute: Route = array[7]
            
            XCTAssertEqual(seventhRoute.type, .bike_sharing, "Seventh route type: \(seventhRoute.type)")
            XCTAssertEqual(seventhRoute.provider?.displayName, "Call a Bike", "Seventh route Provider name: \(seventhRoute.provider?.displayName)")
            XCTAssertEqual(seventhRoute.segments.count, 5, "Seventh route segments count: \(seventhRoute.segments.count)")
            XCTAssertEqual(seventhRoute.price.amount, 120, "Seventh route price: \(seventhRoute.price.amount)")
            let properties = seventhRoute.properties as? BikeSharingProperties
            XCTAssertEqual(properties?.availableBikes, 11, "Available bikes: \(properties?.availableBikes)")
            
            XCTAssertNil(error)
            
            asyncApiCallExpectation.fulfill()
        }

        self.waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error)
        }

    }

    
}
