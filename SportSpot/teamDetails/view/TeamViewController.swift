//
//  TeamViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 27/04/2024.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TeamViewProtocol {
    
    @IBOutlet weak var playersTableView: UITableView!
    var playes: [TeamDetailsModel] = []


    var activityIndicator: UIActivityIndicatorView!
   
    var teamId : Int?
    var sport : String?
    
    var presenter : TeamPresenter?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playersTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        
        playersTableView.estimatedRowHeight = 100
        playersTableView.rowHeight = UITableView.automaticDimension
            
        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        presenter = TeamPresenter()
        presenter?.initLeaguesView(view: self)
        presenter?.fetchPlayers(sport: sport!, teamId: teamId!)
        
    }

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! TeamTableViewCell
        
        
        let player = playes[indexPath.row]
        cell.playerName.text =  ""  //player.league_name ?? "Unknown League"
        
        
        /*
        if let imageUrlString = league.league_logo, let imageUrl = URL(string: imageUrlString) {
              cell.leagueImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Football"))
          } else {
              cell.leagueImage.image = UIImage(named: "Football")
          }
          
        */
        
          cell.playerImage.layer.cornerRadius = cell.playerImage.bounds.width / 2
          cell.playerImage.clipsToBounds = true
       
        return cell
    }
    
    func fetchTeamDeatilsOnTableView(players: [TeamDetailsModel]) {
        
        DispatchQueue.main.async {
            
            self.playes = players
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.playersTableView.reloadData()
        }
    }
    
}