//
//  FootballResponse.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//

import Foundation

struct LeagueModel : Codable{
    
    let league_key: Int?
    let league_name: String?
    let country_key: Int?
    let country_name: String?
    let league_logo: String?
    let country_logo: String?
}


struct LeagueResponse: Codable {
    let success:Int?
    let result:[LeagueModel]?
}
