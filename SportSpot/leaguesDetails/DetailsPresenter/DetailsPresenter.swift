//
//  DetailsPresenter.swift
//  SportSpot
//
//  Created by rwan elmtary on 27/04/2024.
//

import Foundation
class DetailsPresenter{
    var view: LeaguesDetailsProtocol?
    
    func startDetailsView(view: LeaguesDetailsProtocol?){
        self.view = view
    }
    
    func fetchAllTeams(sport: String, leagueId: Int) {
        
        Network.shared.fetchTeams(sportType: sport, leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let teamsResponse):
                self!.view?.getTeams(teams:  teamsResponse.result!)
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchAllFixture(sport: String, leagueId: Int) {
        Network.shared.fetchFixtures(sportType: sport, leagueId: leagueId) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fixtureResponse):
                guard let fixtures = fixtureResponse.result else {
                    print("Error: No fixtures")
                    return
                }
                
                var upcomingFixtures: [FixturesModel] = []
                var latestMatch: [FixturesModel] = []
                
                for fixture in fixtures {
                    if fixture.event_final_result == "" {
                        upcomingFixtures.append(fixture)
                    } else {
                        latestMatch.append(fixture)
                    }
                }
                
                self.view?.getUpcomingFixtures(fixtures: upcomingFixtures)
                self.view?.getLatestMatches(fixtures: latestMatch)
                
            case .failure(let error):
                print("Error fetching fixtures: \(error.localizedDescription)")
            }
        }
    }
}
