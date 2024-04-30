//
//  FixturesTest.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import XCTest
@testable import SportSpot


final class FixturesTest: XCTestCase {
    
    var mockObj : MockNetworkFixtures!
    
    override func setUpWithError() throws {
        mockObj = MockNetworkFixtures(shouldReturnError: false)
    }
    
    func testFetchFixturesFromJson(){
        
        mockObj.fetchFixturesFromJSON { Result, error in
            if let error = error{
                XCTFail()
            }else{
                XCTAssertNotNil(Result)
            }
        }
    }

}
