//
//  FixtureExpectationTest.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import XCTest
@testable import SportSpot

class FixtureExpectationTest: XCTestCase {
    
    func testFetchFixturesFromJson(){
        let myExpectation = expectation(description: "waiting API")
        
        
        Network.shared.fetchFixtures(sportType: "football", leagueId: 123) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue((response.result?.count) != nil)
            case .failure(let error):
                XCTFail("Failed to fetch fixtures with error: \(error.localizedDescription)")
            }
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 15)
    }



}
