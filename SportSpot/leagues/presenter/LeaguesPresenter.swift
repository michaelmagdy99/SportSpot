//
//  LeaguesPresenter.swift
//  SportSpot
//
//  Created by Michael Magdy on 25/04/2024.
//

import Foundation


class LeaguesPresenter {
    
    var view: LeagueViewProtocol?

    func initLeaguesView(view: LeagueViewProtocol?){
        self.view = view
    }
    
    func fetchLeagues(sport: String) {
        
        Network.shared.fetchLeagues(sportType: sport ) { [weak self] result in
            switch result {
            case .success(let leagueResponse):
                self!.view?.fetchLeaguesOnTableView(leagues :leagueResponse.result!)
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
            }
        }
        
    }
    
}
