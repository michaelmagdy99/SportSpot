//
//  TeamViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 27/04/2024.
//

import UIKit
import SDWebImage

class TeamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var playersTableView: UITableView!

    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var coachName: UILabel!
    
    var team : TeamsModel?
    
    var teamPlayes: [Player] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playersTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")

        
        teamPlayes = team?.players ?? []
  
        playersTableView.estimatedRowHeight = 100
        playersTableView.rowHeight = UITableView.automaticDimension
            
        self.playersTableView.dataSource = self
        self.playersTableView.delegate = self
        
        self.teamImage.sd_setImage(with: URL(string: team?.team_logo ?? ""), placeholderImage: UIImage(named: "Football"))
        
        teamName.text = team?.team_name
        coachName.text = team?.coaches?[0].coach_name
        playersTableView.reloadData()

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
        return teamPlayes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! TeamTableViewCell
        
        
        let team = teamPlayes[indexPath.row]
        
        
        cell.playerName.text = team.player_name
          
        if let firstPlayerImage = team.player_image {
              cell.playerImage.sd_setImage(with: URL(string: firstPlayerImage), placeholderImage: UIImage(named: "Football"))
          }
        
        
          cell.playerImage.layer.cornerRadius = cell.playerImage.bounds.width / 2
          cell.playerImage.clipsToBounds = true
        
        
        cell.layer.borderColor = UIColor.yellow.cgColor
         cell.layer.borderWidth = 2
         
          
       
        return cell
    }
    
}
