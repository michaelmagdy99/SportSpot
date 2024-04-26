//
//  LeaguesViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit
import SDWebImage

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var leagueTableView: UITableView!
    
    @IBOutlet weak var sportTextTitle: UILabel!
    var leagues: [LeagueModel] = []

    
    var sport : String?
        
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leagueTableView.register(UINib(nibName: "LeagueCellTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")

        leagueTableView.estimatedRowHeight = 100
        leagueTableView.rowHeight = UITableView.automaticDimension

        self.leagueTableView.dataSource = self
        self.leagueTableView.delegate = self
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        
        sportTextTitle.text = sport!.capitalized

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 100
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLeaguesOnTableView()
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
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCellTableViewCell
           
        let league = leagues[indexPath.row]
        cell.leagueName.text = league.league_name ?? "Unknown League"
        
        
        
        if let imageUrlString = league.league_logo, let imageUrl = URL(string: imageUrlString) {
              cell.leagueImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "Football"))
          } else {
              cell.leagueImage.image = UIImage(named: "Football")
          }
          
          cell.leagueImage.layer.cornerRadius = cell.leagueImage.bounds.width / 2
          cell.leagueImage.clipsToBounds = true
          
        return cell
    }

    
    func fetchLeaguesOnTableView() {
        Network.shared.fetchLeagues(sportType: sport ?? "") { result in
            switch result {
            case .success(let leagueResponse):
                self.leagues = leagueResponse.result!
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.leagueTableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let leagueIndex = leagues[indexPath.row]
        let detailsVC = LeaguesDetailsViewController()
        detailsVC.sportType = sport
        detailsVC.leagueID = leagueIndex.league_key
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }

}
