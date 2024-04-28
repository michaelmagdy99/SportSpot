//
//  ReloadProtocol.swift
//  SportSpot
//
//  Created by rwan elmtary on 28/04/2024.
//

import Foundation
protocol CoreProtocol
{
  //  func reload()
   static func saveLeague(league: LeagueModel, leagueType: String)
    static func fetchFavoriteLeagues() -> [FavLeagues]

}

