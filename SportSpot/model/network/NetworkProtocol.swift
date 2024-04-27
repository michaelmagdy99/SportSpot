//
//  NetworkProtocol.swift
//  SportSpot
//
//  Created by Michael Magdy on 25/04/2024.
//

import Foundation

protocol NetworkProtocol {
    func fetchLeagues(sportType:String,completion: @escaping(Result<LeagueResponse,Error>) -> Void)
    
}
