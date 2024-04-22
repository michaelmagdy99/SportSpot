//
//  FootballResponse.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//

import Foundation

struct FootballResponse : Codable{
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo, countryLogo: String?
    
    enum CodingKeys: String, CodingKey {
            case leagueKey = "league_key"
            case leagueName = "league_name"
            case countryKey = "country_key"
            case countryName = "country_name"
            case leagueLogo = "league_logo"
            case countryLogo = "country_logo"
        }
}
