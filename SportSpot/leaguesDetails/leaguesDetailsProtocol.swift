//
//  leaguesDetailsProtocol.swift
//  SportSpot
//
//  Created by rwan elmtary on 27/04/2024.
//

import Foundation
protocol LeaguesDetailsProtocol{
    func getTeams(teams:[TeamsModel])
    func  getUpcomingFixtures(fixtures:[FixturesModel])
    func getLatestMatches(fixtures:[FixturesModel])

}
