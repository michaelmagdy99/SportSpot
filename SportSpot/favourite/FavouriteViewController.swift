//
//  FavouriteViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,FavProtocol {
    
    
    
    
    
    
    @IBOutlet weak var favTable: UITableView!
    var favoriteLeagues: [FavLeagues] = []
    var coreDataManager = CoreDataManager.shared
    var presenter : FavPresenter?
    var leagues: [LeagueModel] = []

    
    var sport : String?

       
       override func viewDidLoad() {
           super.viewDidLoad()
          addNibFile()
         //fetchFavoriteLeagues()
           getPresenter()
        fetchFav(favoriteLeagues: favoriteLeagues)
    }
    func getPresenter(){
        presenter = FavPresenter()
        presenter?.startFavView(view: self)
        presenter?.fetchFromCoreData()
    }
    func fetchFav(favoriteLeagues: [FavLeagues]) {
        self . favoriteLeagues = favoriteLeagues
        DispatchQueue.main.async {
            self.favTable.reloadData()
        }
    }
   
    

    func addNibFile() {
        favTable.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favcell")
        favTable.dataSource = self
        favTable.delegate = self
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLeagues.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favcell", for: indexPath) as! FavouriteTableViewCell
        let league = favoriteLeagues[indexPath.row]
        cell.favLeague.text = league.leagueName
        if let imageUrlString = league.leagueLogo, let imageUrl = URL(string: imageUrlString) {
            cell.favImg.sd_setImage(with: imageUrl)
        } else {
            cell.favImg.image = UIImage(named: "Image")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let league = favoriteLeagues[indexPath.row]
        let detailsVC = LeaguesDetailsViewController()
        detailsVC.sportType = sport
        detailsVC.leagueID = Int(league.leagueKey)
        
        detailsVC.leagueType = sport
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
