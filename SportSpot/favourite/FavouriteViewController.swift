//
//  FavouriteViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var favTable: UITableView!
    var favoriteLeagues: [FavLeagues] = []
    var coreDataManager = CoreDataManager.shared
       
       override func viewDidLoad() {
           super.viewDidLoad()
        //   favoriteLeagues = coreDataManager.fetchFavoriteLeagues()
        addNibFile()
       // addLoadingIcon()
        favTable.reloadData()
    }

    func addNibFile() {
        favTable.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favcell")
        favTable.dataSource = self
        favTable.delegate = self
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
}
