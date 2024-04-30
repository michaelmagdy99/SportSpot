//
//  MokeLeagues.swift
//  SportSpotTests
//
//  Created by Michael Magdy on 01/05/2024.
//
import Foundation
@testable import SportSpot

class MockLeagues {
    
    var shouldReturnError: Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    let fakeJsonObj: [String: Any] = [
       
        "result": [
            "league_key": "205",
            "league_name": "Coppa Italia",
            "country_key": "5",
            "country_name": "Italy",
            "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png",
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png"
        ]
    ]
}

extension MockLeagues {
    
    func fetchLeaguesFromJSON(completionHandler: @escaping (LeagueModel?, Error?) -> Void) {
        
        var result : LeagueModel

        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJsonObj)
            result = try JSONDecoder().decode(LeagueModel.self, from: data)
            
            completionHandler(result, nil)
            
        } catch {
            completionHandler(nil, error)
        }
    }
}
