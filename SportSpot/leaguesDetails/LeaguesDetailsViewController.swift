//
//  LeaguesDetailsViewController.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit
import SDWebImage
import CoreData


class LeaguesDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, LeaguesDetailsProtocol {
    
    var fixture : [FixturesModel] = []
    var upcomingFixtures: [FixturesModel] = []
    var latestMatch: [FixturesModel] = []
    var teams : [TeamsModel] = []
    var activityIndicator: UIActivityIndicatorView!
    var league : LeagueModel?
    var fav : [LeagueModel] = []
    
    var sportType : String?
    var leagueID : Int?
    var teamID : Int?
    var presenter : DetailsPresenter?
    var leagueType:String?
    var delegate:FavProtocol?
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getPresenter()
        addNibFile()
        addLoadingIcon()
        startCompositional()
        getLatestMatches(fixtures: fixture)
        getUpcomingFixtures(fixtures: fixture)
        getTeams(teams: teams)
       // delegate?.reload()
        
      
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addButtonTapped(_:)))

        navigationItem.rightBarButtonItem = addButton

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        delegate?.reload()

    }
   
    
    // add button in tool bar
    @objc func addButtonTapped(_ sender: UIBarButtonItem) {
        presenter?.saveToCoreData(league: league!, leagueType: leagueType!)
    }
    
    
    func getPresenter(){
        presenter = DetailsPresenter()
        presenter?.startDetailsView(view: self)
        presenter?.fetchAllTeams(sport: sportType!, leagueId: leagueID ?? 488978951)
        presenter?.fetchAllFixture(sport: sportType!, leagueId: leagueID ?? 488978951)
        
    }
    
    func addNibFile() {
        
        collection.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")

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
    
    
    func getUpcomingFixtures(fixtures: [FixturesModel]) {
        self.upcomingFixtures = fixtures
      
        print("\(self.upcomingFixtures.count)")
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.collection.reloadData()
        }
    }
    
    func getLatestMatches(fixtures: [FixturesModel]) {
        self.latestMatch = fixtures

        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.collection.reloadData()
        }
    }
    
    
    func getTeams(teams:[TeamsModel]){
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.teams = teams
            self.collection.reloadData()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return upcomingFixtures.isEmpty ? 1 : upcomingFixtures.count
        case 1:
            return latestMatch.isEmpty ? 1 : latestMatch.count
        case 2:
            return !teams.isEmpty ? teams.count : 0
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
            
            if upcomingFixtures.isEmpty {
                
                cell.team1.image = UIImage(named: "Image")
                cell.team2.image = UIImage(named: "Image")
                cell.header.text = "No Up Coming Events"
                cell.time.text = "no events"
                cell.date.text =  "no events"
                cell.imgtitle.text =  "no events"
                cell.club2Name.text =  "no events"
                cell.team2.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team2.clipsToBounds = true
                cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team1.clipsToBounds = true
                cell.backgroundColor = UIColor.systemMint
                
            }else{
                
                let upComingFixture = upcomingFixtures[indexPath.row]
                if let imageUrlString = upComingFixture.away_team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.team1.sd_setImage(with: imageUrl)
                } else {
                    cell.team1.image = UIImage(named: "Image")
                }
                
                cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team1.clipsToBounds = true
                
                if let imageUrlString = upComingFixture.home_team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.team2.sd_setImage(with: imageUrl)
                } else {
                    cell.team2.image = UIImage(named: "Image")
                }
                cell.team2.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team2.clipsToBounds = true
                
                cell.date.text = upComingFixture.event_date
                cell.time.text = upComingFixture.event_time
                cell.header.text = "Up Comming Events"
                
                cell.imgtitle.text = upComingFixture.event_home_team
                cell.club2Name.text = upComingFixture.event_away_team
                
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 5
                
                cell.backgroundColor = UIColor.systemMint
                
                
                
                print("aaaaaaaa")
                
                
            }
            
            case 1:
            
            
            if latestMatch.isEmpty {
                
                cell.team1.image = UIImage(named: "Image")
                cell.team2.image = UIImage(named: "Image")
                cell.header.text = "No Latest Events"
                cell.time.text =  "no events"
                cell.date.text =  "no events"
                cell.imgtitle.text =  "no events"
                cell.club2Name.text =  "no events"
                cell.backgroundColor = UIColor.systemMint
                
            }else{
                
                let latestMatch = latestMatch [indexPath.row]
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
                
                
                cell.imgtitle.text = latestMatch.event_home_team
                cell.club2Name.text = latestMatch.event_away_team
                
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.borderWidth = 5
                
               cell.backgroundColor = UIColor.systemMint
                
                
                print("yyyy")
                
            }
            
        
        case 2:
            
            if teams.isEmpty {
                
                cell.team1.image = UIImage(named: "Image")
                cell.team2.image = UIImage(named: "Image")
                cell.header.text = "No Up Coming Events"
                cell.time.text =  "no events"
                cell.date.text =  "no events"
                cell.imgtitle.text =  "no events"
                cell.club2Name.text =  "no events"
                cell.backgroundColor = UIColor.systemMint
                
            }else{
                let team = teams[indexPath.row]
                if let imageUrlString = team.team_logo, let imageUrl = URL(string: imageUrlString) {
                    cell.team1.sd_setImage(with: imageUrl)
                } else {
                    cell.team1.image = UIImage(named: "Image")
                }
                cell.team1.layer.cornerRadius = cell.team1.bounds.width / 2
                cell.team1.clipsToBounds = true
                cell.header.text = "Teams"
                cell.imgtitle.text = team.team_name
                
                cell.backgroundColor = UIColor.systemMint
                
                print("zzzzz")
                
            }
        default:
                print("NO Section")
        }
        
        
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
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 20
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                                
                                section.boundarySupplementaryItems = [headerSupplementary]
    
        
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                                
                                section.boundarySupplementaryItems = [headerSupplementary]
    
        return section
    }
    
    func drawToTheBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                                
                                section.boundarySupplementaryItems = [headerSupplementary]
    
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
            teamDetailsVC.team = teamIndex
            navigationController?.pushViewController(teamDetailsVC, animated: true)
            break
        default:
            print("NO SECTION HERE")
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
               guard kind == UICollectionView.elementKindSectionHeader else {
                   return UICollectionReusableView()
               }
               
               let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! SectionHeaderView
               
               // Customize the header view based on the section
               switch indexPath.section {
               case 0:
                   if upcomingFixtures.count == 0{
                       headerView.titleLabel.text = "No Upcoming Matches"
                   }else{
                       headerView.titleLabel.text = "Upcoming Matches"
                   }
               case 1:
                   if latestMatch.count == 0 {
                       headerView.titleLabel.text = "No Latest Matches"

                   }else{
                       headerView.titleLabel.text = "Latest Matches"
                   }
               case 2:
                   if teams.count == 0 {
                       headerView.titleLabel.text = "No Teams"
                   }else{
                       headerView.titleLabel.text = "Teams"
                   }
               default:
                   headerView.titleLabel.text = ""
               }
               
               return headerView
           }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                return CGSize(width: collectionView.bounds.width, height: 50)
            }
}

