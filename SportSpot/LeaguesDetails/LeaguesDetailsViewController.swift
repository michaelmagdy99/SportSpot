//
//  LeaguesDetailsViewController.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit
import SDWebImage
import CoreData


class LeaguesDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, LeaguesDetailsProtocol{
   
    
  
    
    
    var fixture : [FixturesModel] = []
    var upcomingFixtures: [FixturesModel] = []
    var latestMatch: [FixturesModel] = []
    var teams : [TeamsModel] = []
    var activityIndicator: UIActivityIndicatorView!
    
    var sportType : String?
    var leagueID : Int?
    var teamID : Int?
   var presenter : DetailsPresenter?
    
    
    var leagueName: String?
        var leagueLogo: String?
        var countryName: String?
        var countryLogo: String?
        var countryID: Int16?
        var leagueId: Int16?
    var context : NSManagedObjectContext?
    var coreDataManager = CoreDataManager.shared
      

    @IBAction func addToFavoritesButtonTapped(_ sender: UIButton) {
        guard let leagueKey = leagueId,
              let leagueName = leagueName,
              let leagueLogo = leagueLogo else {
            return
        }
        
        let leagueData: [String: Any] = [
            "leagueKey": leagueKey,
            "leagueName": leagueName,
            "leagueLogo": leagueLogo
        ]
        
        CoreDataManager.shared.saveLeague(leagueData)
        
        let alert = UIAlertController(title: "Added to Favorites", message: "The league has been added to your favorites.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addNibFile()
        addLoadingIcon()
        startCompositional()
        getLatestMatches(fixtures: fixture)
        getUpcomingFixtures(fixtures: fixture)
        getPresenter()
        getTeams(teams: teams)
    }

    @IBAction func addToFav(_ sender: Any) {
    }
    func getPresenter(){
        presenter = DetailsPresenter()
        presenter?.startDetailsView(view: self)
        presenter?.fetchAllTeams(sport: sportType!, leagueId: leagueID ?? 488978951)
        presenter?.fetchAllFixture(sport: sportType!, leagueId: leagueID ?? 488978951)
        
    }
    
    func addNibFile() {
        collection.register(UINib(nibName: "LeaguesDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "leagueDcell")
        
        self.collection.dataSource = self
        self.collection.delegate = self
    }

    func addLoadingIcon() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
    }

//    func fetchData() {
//
//        print("\(leagueID ?? 488978951)")
//        Network.shared.fetchFixtures(sportType: sportType!, leagueId: leagueID!) { result in
//
//            switch result {
//            case .success(let fixture):
//
//                if let fixtures = fixture.result {
//                    self.fixture = fixtures
//
//                    for result in fixtures{
//                        if result.event_ft_result == ""{
//                            self.upcomingFixtures.append(result)
//                        }else{
//                            self.latestMatch.append(result)
//                        }
//                    }
//
//
//
//                    /*
//                    if let latest = fixtures.last {
//                        self.latestMatch = [latest]
//                        print("Latest match date: \(latest.event_date)")
//                    }
//
//                    */
//                }
//
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.activityIndicator.isHidden = true
//                    self.collection.reloadData()
//                    print(self.upcomingFixtures.count)
//                    print(self.latestMatch.count)
//                }
//            case .failure(let error):
//                print("Error fetching leagues: \(error.localizedDescription)")
//                self.activityIndicator.stopAnimating()
//                self.activityIndicator.isHidden = true
//            }
//            print("Success")
//        }
//    }
    
//    func getFixtures(fixtures: [FixturesModel]) {
//        self.fixture = fixtures
//        self.collection.reloadData()
//    }
    func getUpcomingFixtures(fixtures: [FixturesModel]) {
        self.upcomingFixtures = fixtures
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
        
        func getLatestMatches(fixtures: [FixturesModel]) {
            self.latestMatch = fixtures
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        }
        
        
        func getTeams(teams:[TeamsModel])
        {
            
            DispatchQueue.main.async {
                self.teams = teams
                self.collection.reloadData()
            }
            
        }
        //    func getTeams(){
        //        Network.shared.fetchTeams(sportType: sportType!, leagueId: leagueID!){result in
        //            switch result{
        //            case.success(let TeamsResponse):
        //                self.teams = TeamsResponse.result!
        //
        //                DispatchQueue.main.async {
        //                    self.collection.reloadData()
        //                }
        //            case .failure(let error):
        //             print("Error fetching teams: \(error.localizedDescription)")
        //
        //
        //            }
        //
        //        }
        //    }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            switch section {
            case 0:
                return upcomingFixtures.count
            case 1:
                return !latestMatch.isEmpty ? latestMatch.count : 0
            case 2:
                return teams.count
            default:
                return 0
            }
            
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 3
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueDcell", for: indexPath) as! LeaguesDetailsCollectionViewCell
            
            switch indexPath.section {
            case 0:
                let fixture = upcomingFixtures[indexPath.row]
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
                cell.header.text = "Up Comming Events"
                cell.imgtitle.text = ""
                
                print("aaaaaaaa")
            case 1:
                let latestMatch = latestMatch [indexPath.row]
                //   if let latestMatch = latestMatch.first {
                if let imageUrlString = latestMatch.away_team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.team1.sd_setImage(with: imageUrl)
                } else {
                    cell.team1.image = UIImage(named: "Image")
                }
                cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team1.clipsToBounds = true
                
                if let imageUrlString = latestMatch.home_team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.team2.sd_setImage(with: imageUrl)
                } else {
                    cell.team2.image = UIImage(named: "Image")
                }
                cell.team2.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team2.clipsToBounds = true
                
                cell.date.text = latestMatch.event_date
                cell.time.text = latestMatch.event_final_result
                cell.header.text = "Latest Events"
                cell.imgtitle.text = ""
                
                
            case 2:
                let team = teams[indexPath.row]
                if let imageUrlString = team.teamLogo, let imageUrl = URL(string: imageUrlString) {
                    cell.team1.sd_setImage(with: imageUrl)
                } else {
                    cell.team1.image = UIImage(named: "Image")
                }
                cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team1.clipsToBounds = true
                cell.header.text = "Teams"
                cell.imgtitle.text = team.teamName
                
                
                
                //  cell.team1.contentMode = .scaleAspectFit
                
                
            default:
                let backgroundImg = UIImageView(image: UIImage(named: "Image 1"))
                backgroundImg.contentMode = .scaleAspectFill
                collection.backgroundView = backgroundImg
            }
            print("zzzzz")
            
            
            return cell
        }
        
        
        
        
        // compositional Part
        func drawToTheTopSection() -> NSCollectionLayoutSection {
            let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            
            let item = NSCollectionLayoutItem(layoutSize: itemsSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        
        func drawToTheCenterSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            section.interGroupSpacing = 20
            
            return section
        }
        
        func drawToTheBottomSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.5))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
        
        
        
        
        // Init compositional func
        func startCompositional() {
            let layout = UICollectionViewCompositionalLayout { index, environment in
                switch index {
                case 0:
                    return self.drawToTheTopSection()
                case 1:
                    return self.drawToTheCenterSection()
                case 2:
                    return self.drawToTheBottomSection()
                default:
                    return nil
                }
            }
            collection.collectionViewLayout = layout
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            let teamIndex = teams[indexPath.row]
            switch indexPath.section {
            case 0 :
                print("section 0")
                break
            case 1 :
                print("section 1")
                break
            case 2:
                let teamDetailsVC = TeamViewController()
                teamDetailsVC.teamId = teamIndex.teamKey
                teamDetailsVC.sport = sportType
                print("team id in league : \(teamIndex.teamKey)")
                navigationController?.pushViewController(teamDetailsVC, animated: true)
                break
            default:
                print("NO SECTION HERE")
            }
            
        }
        
    }

