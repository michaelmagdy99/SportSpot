//
//  DetailsPresenter.swift
//  SportSpot
//
//  Created by rwan elmtary on 27/04/2024.
//

import Foundation
class DetailsPresenter{
    var view: LeaguesDetailsProtocol?
    
    var upcomingFixtures: [FixturesModel] = []
    var latestMatch: [FixturesModel] = []
    
    
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
                print("\(fixtures[0].event_ft_result)")
                
                for result in fixtures {
                    if result.event_ft_result == "" {
                        self.upcomingFixtures.append(result)
                    } else {
                        self.latestMatch.append(result)
                    }
                }
                
                self.view?.getUpcomingFixtures(fixtures: self.upcomingFixtures)
                self.view?.getLatestMatches(fixtures: self.latestMatch)
                
            case .failure(let error):
                print("Error fetching fixtures: \(error.localizedDescription)")
            }
        }
    }

    
    func saveToCoreData(league: LeagueModel , leagueType: String){
        CoreDataManager.saveLeague(league: league, leagueType: leagueType)
        FavPresenter().fetchFromCoreData()
    }
}
