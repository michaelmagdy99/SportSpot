//
//  TeamDetailsResponse.swift
//  SportSpot
//
//  Created by Michael Magdy on 27/04/2024.
//

import Foundation

struct TeamDetailsResponse: Codable {
    let success: Int?
    let result: [TeamDetailsModel]?
}

struct TeamDetailsModel: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
    let coaches: [Coach]?
}

struct Coach: Codable {
    let coach_name: String
    let coach_country: String?
    let coach_age: Int?
}

struct Player: Codable {
    let player_key: Int?
    let player_image: String?
    let player_name: String?
    let player_number: String?
    let player_country: String?
    let player_type: String?
    let player_age: Int?
    let player_match_played: String?
    let player_goals: String?
    let player_injured: Bool?
}


enum PlayerType: String {
    case defenders
    case forwards
    
    case goal_keepers
    case midfielders
}
