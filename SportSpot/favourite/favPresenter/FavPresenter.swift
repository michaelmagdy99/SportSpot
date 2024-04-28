//
//  FavPresenter.swift
//  SportSpot
//
//  Created by rwan elmtary on 28/04/2024.
//

import Foundation
class FavPresenter {
    var view: FavProtocol?
    var favoriteLeagues: [FavLeagues] = []

    
    func startFavView(view: FavProtocol?){
        self.view = view
    }
    
    
    func fetchFromCoreData() {
        favoriteLeagues = CoreDataManager.fetchFavoriteLeagues()
        view?.fetchFav(favoriteLeagues: favoriteLeagues)
    }



    func deleteFavoriteLeague(atIndex index: Int) {
        guard index >= 0 && index < favoriteLeagues.count else {
            print("Index out of range")
            return
        }
        
        let leagueToRemove = favoriteLeagues[index]
        CoreDataManager.deleteFavoriteLeague(leagueKey: Int(leagueToRemove.leagueKey))
        favoriteLeagues.remove(at: index)
        view?.fetchFav(favoriteLeagues: favoriteLeagues)
    }

    
}
