//
//  SportSpotTests.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import XCTest
@testable import SportSpot

final class SportSpotTests: XCTestCase {
    
    var mockObjFix : MockNetworkFixtures!
    var mockObjTeam :MockNetworkTeams!
    var mockObjLeague :MockLeagues!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockObjFix = MockNetworkFixtures(shouldReturnError: false)
        mockObjTeam = MockNetworkTeams(shouldReturnError: false)
        mockObjLeague = MockLeagues(shouldReturnError: false)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    
    func testFetchDataFromMockingJson() {

        mockObjLeague.fetchLeaguesFromJSON {
            result, error in
            
            if error != nil {
                XCTFail()
            }else{
                XCTAssertNotNil(result)
            }
        }
    }
    
   
    func testFetchFixturesFromJson(){
        
        mockObjFix.fetchFixturesFromJSON { Result, error in
            if let error = error{
                XCTFail()
            }else{
                XCTAssertNotNil(Result)
            }
        }
    }

    func testFetchTeamsFromJson(){
        
        mockObjTeam.fetchTeamsFromJSON { Result, error in
            if let error = error{
                XCTFail()
            }else{
                XCTAssertNotNil(Result)
            }
        }
    }

    
    func testFetchFixturesFromNetwork(){
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


    func testFetchTeamsFromNetwork() {
        let myExpectation = expectation(description: "waiting API")
        
        
        Network.shared.fetchTeams(sportType: "football", leagueId: 123) { result in
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

    
    func testFetchLeaguesFromNetwork(){
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


