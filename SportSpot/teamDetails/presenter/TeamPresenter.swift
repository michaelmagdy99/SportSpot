//
//  TeamPresenter.swift
//  SportSpot
//
//  Created by Michael Magdy on 27/04/2024.
//

import Foundation


class TeamPresenter {
    var view: TeamViewProtocol?
    
    func initLeaguesView(view: TeamViewProtocol?){
        self.view = view
    }
    
    func fetchPlayers(sport: String, teamId: Int) {
        
        Network.shared.fetchTeamDetails(sportType: sport, teamId: teamId) { [weak self] result in
                switch result {
                case .success(let playersResponse):
                    self!.view?.fetchTeamDeatilsOnTableView(players: playersResponse.result!)
                case .failure(let error):
                    print("Error fetching leagues: \(error.localizedDescription)")
                }
            }
        }
}
