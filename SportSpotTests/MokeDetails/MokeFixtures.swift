//
//  MokeFixtures.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import Foundation
@testable import SportSpot

class MockNetworkFixtures {
    
    var shouldReturnError:Bool
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    let fakeJsonObj :[String:Any] =
    [
        "result": [
            
            "event_key": 1387770,
            "event_date": "2024-04-27",
            "event_time": "23:00",
            "event_home_team": "Votuporanguense",
            "home_team_key": 1990,
            "event_away_team": "Gremio Prudente",
            "away_team_key": 30414,
            "event_halftime_result": "1 - 0",
            "event_final_result": "1 - 0",
            "event_ft_result": "1 - 0",
            "event_penalty_result": "",
            "event_status": "Finished",
            "country_name": "Brazil",
            "league_name": "Paulista A3 - Finals",
            "league_key": 96,
            "league_round": "",
            "league_season": "2024",
            "event_live": "0",
            "event_stadium": "Estádio Municipal Dr. Plínio Marin (Votuporanga, São Paulo)",
            "event_referee": "Herminio Henrique Kuhn Daldem",
            "home_team_logo": "https://apiv2.allsportsapi.com/logo/1990_votuporanguense.jpg",
            "away_team_logo": "https://apiv2.allsportsapi.com/logo/30414_gremio-prudente.jpg",
            "event_country_key": 27,
            "league_logo": nil,
            "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/27_brazil.png",
            "event_home_formation": "",
            "event_away_formation": "",
            "fk_stage_key": 2442,
            "stage_name": "Finals",
            "league_group": nil,
        ]
    ]
    enum ResponseWithError: Error{
        case responserError
    }
}

extension MockNetworkFixtures {
    func fetchFixturesFromJSON(completionHandler: @escaping (FixturesModel?, Error?) -> Void) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJsonObj)
            let result = try JSONDecoder().decode(FixturesModel.self, from: data)
            completionHandler(result, nil)
            
        } catch {
            completionHandler(nil, error)
        }
    }
}

    


