//
//  FavouriteViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,FavProtocol , CheckNetworkDelegate {
  
    
    
    let checkNetwork = CheckNetwork()
    
    
    
    
    
    
    @IBOutlet weak var favTable: UITableView!
    var favoriteLeagues: [FavLeagues] = []
    var coreDataManager = CoreDataManager.shared
    var presenter : FavPresenter?
    var leagues: [LeagueModel] = []
    
    
    var sport : String?
    
    @IBOutlet weak var backGroundImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNibFile()
        //fetchFavoriteLeagues()
        //reload()
       // getPresenter()
       fetchFav(favoriteLeagues: favoriteLeagues)
        
        

    }
    override func viewWillAppear(_ animated: Bool) {
        getPresenter()
        backGroundImg.image = UIImage(named: "Image 1")
    }
    

    override func viewDidAppear(_ animated: Bool) {
        reload()
    }
    func reload() {
        DispatchQueue.main.async {
            self.favTable.reloadData()
        }
    }
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    
    
    func getPresenter(){
        presenter = FavPresenter()
        presenter?.startFavView(view: self)
        presenter?.fetchFromCoreData()
    }
    
    
    func fetchFav(favoriteLeagues: [FavLeagues]) {
        self . favoriteLeagues = favoriteLeagues
        reload()

       backGroundImg.isHidden = !favoriteLeagues.isEmpty

       
    }
    
    
    
    func addNibFile() {
        favTable.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favcell")
        favTable.dataSource = self
        favTable.delegate = self
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favoriteLeagues.count)
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
        
        cell.favImg.layer.cornerRadius = cell.favImg.bounds.width / 2
        cell.favImg.clipsToBounds = true
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //check network
        checkNetwork.delegate = self

        let league = favoriteLeagues[indexPath.row]
        let detailsVC = LeaguesDetailsViewController()
        detailsVC.sportType = "football"
        detailsVC.leagueID = Int(league.leagueKey)
        //detailsVC.leagueType = "sport"
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueToRemove = favoriteLeagues[indexPath.row]
            
            let alertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this league?", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
                
                
                
                self.favoriteLeagues.remove(at: indexPath.row)
                self.presenter?.deleteFavoriteLeague(atIndex: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                
            }
            alertController.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func showNoNetworkAlert() {
         let alertController = UIAlertController(title: "No Internet Connection", message: "Please check your network settings", preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(okAction)
         present(alertController, animated: true, completion: nil)
     }

}
