//
//  LeaguesMokeTest.swift
//  SportSpotTests
//
//  Created by Michael Magdy on 01/05/2024.
//

import XCTest
@testable import SportSpot

class LeaguesMokeTest : XCTestCase {

    var mockObj :MockLeagues!
        
        override func setUpWithError() throws {
            mockObj = MockLeagues(shouldReturnError: false)
        }
  
    
    
    func testFetchDataFromMockingJson() {

        mockObj.fetchLeaguesFromJSON {
            result, error in
            
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
}
