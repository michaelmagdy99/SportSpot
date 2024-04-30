//
//  TeamsMockTest.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import XCTest
@testable import SportSpot
class TeamsMockTest: XCTestCase {
           
    var mockObj :MockNetworkTeams!
        
        override func setUpWithError() throws {
            mockObj = MockNetworkTeams(shouldReturnError: false)
        }
        
        func testFetchTeamsFromJson(){
            
            mockObj.fetchTeamsFromJSON { Result, error in
                if let error = error{
                    XCTFail()
                }else{
                    XCTAssertNotNil(Result)
                }
            }
        }

    }


