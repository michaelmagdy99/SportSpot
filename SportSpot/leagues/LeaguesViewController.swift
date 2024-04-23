//
//  LeaguesViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var leagueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leagueTableView.register(UINib(nibName: "LeagueCellTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")

        self.leagueTableView.dataSource = self
        self.leagueTableView.delegate = self

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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCellTableViewCell
           
           cell.leagueName.text = "Cell \(indexPath.row)"
           cell.leagueImage.image = UIImage(named: "Basktball")
        return cell
    }

}
