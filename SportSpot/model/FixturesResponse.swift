//
//  FixturesResponse.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import Foundation


struct FixturesResponse :Codable {
    let success:Int?
    let result:[FixturesModel]?
}



struct FixturesModel: Codable {
    let event_key: Int?
    let event_date, event_time, event_home_team: String?
    let home_team_key: Int?
    let event_away_team: String?
    let away_team_key: Int?
    let event_halftime_result, event_final_result, event_ft_result, event_penalty_result: String?
    let event_status, country_name, league_name: String?
    let league_key: Int?
    let league_round, league_season, event_live, event_stadium: String?
    let event_referee: String?
    let home_team_logo, away_team_logo: String?
    let event_country_key: Int?
    let league_logo, country_logo: String?
    let event_home_formation, event_away_formation: String?
    let fk_stage_key: Int?
    let stage_name: String?
    let goalscorers: [Goalscorer]?
    let substitutes: [Substitute]?
    let cards: [Card]?
    let lineups: Lineups?
    let statistics: [Statistic]?
}


struct Card: Codable {
    let time, home_fault, card, away_fault: String?
    let info, home_player_id, away_player_id, info_time: String?
}

struct Substitute: Codable {
    let time: String?
    let score: String?
    let info_time: String?
}

struct Goalscorer: Codable {
    let time, home_scorer, home_scorer_id, home_assist: String?
    let home_assist_id, score, away_scorer, away_scorer_id: String?
    let away_assist, away_assist_id, info, info_time: String?

    
}

struct Lineups: Codable {
    let home_team, away_team: Team?
}

struct Team: Codable {
    let starting_lineups, substitutes: [StartingLineup]?
    let coaches: [Coach]?
}

struct Coach: Codable {
    let coache: String?
}

struct StartingLineup: Codable {
    let player: String?
    let player_number, player_position: Int?
    let player_key: Int?
    let info_time: String?
}

struct Statistic: Codable {
    let type, home, away: String?
}
