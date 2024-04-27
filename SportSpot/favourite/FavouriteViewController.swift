//
//  FavouriteViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 23/04/2024.
//

import UIKit

class FavouriteViewController: UIViewController {
    
    @IBOutlet weak var favTable: UITableView!
    var activityIndicator: UIActivityIndicatorView!

    
    
    func addNibFile() {
        favTable.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favcell")
//        self.favTable.dataSource = self
//        self.favTable.delegate = self
    }

    func addLoadingIcon() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       ret 5
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
