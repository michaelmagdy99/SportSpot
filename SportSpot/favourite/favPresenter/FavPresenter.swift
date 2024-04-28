//
//  FavPresenter.swift
//  SportSpot
//
//  Created by rwan elmtary on 28/04/2024.
//

import Foundation
class FavPresenter {
    var view: FavProtocol?
    
    func startFavView(view: FavProtocol?){
        self.view = view
    }
    func fetchFromCoreData() {
        let favoriteLeagues = CoreDataManager.fetchFavoriteLeagues()
              
              view?.fetchFav(favoriteLeagues: favoriteLeagues)
        
    }
    
}
