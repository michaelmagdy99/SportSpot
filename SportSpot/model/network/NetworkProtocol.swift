//
//  NetworkProtocol.swift
//  SportSpot
//
//  Created by Michael Magdy on 25/04/2024.
//

import Foundation

protocol NetworkProtocol {
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void)
    func fetchFixtures(sportType: String, leagueId : Int, completion: @escaping(Result<FixturesResponse, Error>) -> Void)
    func fetchTeams(sportType: String, leagueId : Int, completion: @escaping(Result<TeamsResponse, Error>) -> Void)    
}
