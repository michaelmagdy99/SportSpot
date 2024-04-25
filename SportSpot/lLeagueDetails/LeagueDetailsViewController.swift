//
//  LeagueDetailsViewController.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit
import SDWebImage


class LeagueDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var leaguesDetails : [FixturesModel] = []
    var sport : String?
    var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var leagueTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueTable.register(UINib(nibName: "LeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueDcell")
        self.leagueTable.dataSource = self
        self.leagueTable.delegate = self

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        
//
//        let layout = UITableViewLayout()
//               layout.scrollDirection = .horizontal
//        leagueTable.tablevi = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentDate = Date()
        let threeDaysFromNow = currentDate.adding(days: 3)
        fetchOnCollectionView(from: currentDate, to: threeDaysFromNow)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesDetails.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueDcell", for: indexPath) as!LeagueDetailsTableViewCell
        let fixture = leaguesDetails[indexPath.row]
        
        if let imageUrlString = fixture.away_team_logo, let imageUrl = URL(string: imageUrlString) {
              cell.team1.sd_setImage(with: imageUrl)
          } else {
              cell.team1.image = UIImage(named: "Image")
              
          }
        
        cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
        cell.team1.clipsToBounds = true
        
        
        if let imageUrlString = fixture.home_team_logo, let imageUrl = URL(string: imageUrlString) {
              cell.team2.sd_setImage(with: imageUrl)
          } else {
              cell.team2.image = UIImage(named: "Image")
              
          }
        
        cell.team2.layer.cornerRadius = cell.team1.bounds.width / 2
        cell.team2.clipsToBounds = true
        
        cell.date.text = fixture.event_date
        cell.time.text = fixture.event_time
        return cell
    }
    
    
    func fetchOnCollectionView(from fromDate: Date, to toDate: Date?) {
        Network.shared.fetchFixtures(sportType:  "football", from: fromDate, to: toDate) { result in
            switch result {
            case .success(let fixture):
                self.leaguesDetails = fixture.result!
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.leagueTable.reloadData()
                }
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            print("successed")
        }
    }


    

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
