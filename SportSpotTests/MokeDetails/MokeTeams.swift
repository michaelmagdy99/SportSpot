//
//  MokeTeams.swift
//  SportSpotTests
//
//  Created by rwan elmtary on 30/04/2024.
//

import Foundation
@testable import SportSpot

class MockNetworkTeams{
    
    var shouldReturnError:Bool
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    let fakeJsonTeamsObj :[String:Any] =
    [
        "players": [
                            "player_key": 3843451091,
                            "player_image": nil,
                            "player_name": "Léo Kanu",
                            "player_number": "",
                            "player_country": nil,
                            "player_type": "Defenders",
                            "player_age": "",
                            "player_match_played": "14",
                            "player_goals": "1",
                            "player_yellow_cards": "2",
                            "player_red_cards": "0",
                            "player_injured": "No",
                            "player_substitute_out": "0",
                            "player_substitutes_on_bench": "1",
                            "player_assists": "",
                            "player_birthdate": "1988-01-14",
                            "player_is_captain": "",
                            "player_shots_total": "",
                            "player_goals_conceded": "",
                            "player_fouls_committed": "",
                            "player_tackles": "",
                            "player_blocks": "",
                            "player_crosses_total": "",
                            "player_interceptions": "",
                            "player_clearances": "",
                            "player_dispossesed": "",
                            "player_saves": "",
                            "player_inside_box_saves": "",
                            "player_duels_total": "",
                            "player_duels_won": "",
                            "player_dribble_attempts": "",
                            "player_dribble_succ": "",
                            "player_pen_comm": "",
                            "player_pen_won": "",
                            "player_pen_scored": "",
                            "player_pen_missed": "",
                            "player_passes": "",
                            "player_passes_accuracy": "",
                            "player_key_passes": "",
                            "player_woordworks": "",
                            "player_rating": ""
                            ,]
    ]
    enum ResponseWithError: Error{
        case responserError
    }
}

extension MockNetworkTeams {
    func fetchTeamsFromJSON(completionHandler: @escaping (FixturesModel?, Error?) -> Void) {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: fakeJsonTeamsObj)
            let result = try JSONDecoder().decode(FixturesModel.self, from: data)
            completionHandler(result, nil)
            
        } catch {
            completionHandler(nil, error)
        }
    }
}
