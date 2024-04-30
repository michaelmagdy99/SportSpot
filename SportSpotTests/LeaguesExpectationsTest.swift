//
//  LeaguesExpectationsTest.swift
//  SportSpotTests
//
//  Created by Michael Magdy on 01/05/2024.
//

import XCTest
@testable import SportSpot

class LeaguesExpectationsTest : XCTestCase {
    
    
    func testFetchLeaguesFromJson(){
        let myExpectation = expectation(description: "waiting API")
        
        
        Network.shared.fetchLeagues(sportType: "football") { result in
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
