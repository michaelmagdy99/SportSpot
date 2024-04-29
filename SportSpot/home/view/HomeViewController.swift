//
//  HomeViewController.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CheckNetworkDelegate {
    
    
    let checkNetwork = CheckNetwork()

    
    let sportTypeList = ["Football", "Basktball", "Tennis", "Cricket"]
    let sportTypeListImage = ["Football", "Basktball", "Tennis", "Cricket"]
    
    @IBOutlet weak var sportCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sportCollectionView.register(UINib(nibName: "SportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sportCell")
        
        self.sportCollectionView.dataSource = self
        self.sportCollectionView.delegate = self

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportsCollectionViewCell

        cell.sportTypeText.text = sportTypeList[indexPath.item]
        cell.sportImage.image = UIImage(named: sportTypeListImage[indexPath.item])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          let itemWidth : CGFloat = 175
          let itemHeight: CGFloat = 230
          return CGSize(width: itemWidth, height: itemHeight)
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle cell selection here
        print("Cell at index \(indexPath.item) selected")
        let leaugeVC = LeaguesViewController()
        checkNetwork.delegate = self

        switch indexPath.item{
        case 0 :
            leaugeVC.sport = "football"
            break
        case 1:
            leaugeVC.sport = "basketball"
            break
        case 2:
            leaugeVC.sport = "tennis"
            break
        case 3:
            leaugeVC.sport = "cricket"
        default:
            print("Error in passing hader URL")
        }
        
        navigationController?.pushViewController(leaugeVC, animated: true)
    }
    
    
    func showNoNetworkAlert() {
         let alertController = UIAlertController(title: "No Internet Connection", message: "Please check your network settings", preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(okAction)
         present(alertController, animated: true, completion: nil)
     }
}
