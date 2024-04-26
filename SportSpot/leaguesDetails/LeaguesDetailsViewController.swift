//
//  LeaguesDetailsViewController.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import UIKit
import SDWebImage

class LeaguesDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var upcomingFixtures: [FixturesModel] = []
    var latestMatch: FixturesModel?
    var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addNibFile()
        addLoadingIcon()
        startCompositional()
        fetchData()
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

    func fetchData() {
        let currentDate = Date()
        let threeDaysFromNow = currentDate.adding(days: 3)
        let threeDaysAgo = Calendar.current.date(byAdding: .day, value: -3, to: currentDate)!
        let endOfDay = Calendar.current.startOfDay(for: currentDate).addingTimeInterval(-1)

        Network.shared.fetchFixtures(sportType: "football", from: threeDaysAgo, to: threeDaysFromNow) { result in
            switch result {
            case .success(let fixture):
                if let fixtures = fixture.result {
                    self.upcomingFixtures = fixtures
                    if let latest = fixtures.last {
                        self.latestMatch = latest
                    }
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.collection.reloadData()
                }
            case .failure(let error):
                print("Error fetching leagues: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
            print("Success")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingFixtures.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueDcell", for: indexPath) as! LeaguesDetailsCollectionViewCell
        
        switch indexPath.section {
        case 0:
            let fixture = upcomingFixtures[indexPath.row]
            configureCell(for: cell, with: fixture)
            print("aaaaaaaa")
        case 1:
            if let latestMatch = latestMatch {
                configureCell(for: cell, with: latestMatch)
                print("zzzzz")
            }
        default:
            break
        }
        
        return cell
    }

    func configureCell(for cell: LeaguesDetailsCollectionViewCell, with fixture: FixturesModel) {
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
    }


    // compositional Part
    func drawToTheTopSection() -> NSCollectionLayoutSection {
        let itemsSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let item = NSCollectionLayoutItem(layoutSize: itemsSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        return section
    }

    func drawToTheCenterSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)

        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        section.interGroupSpacing = 20

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
            default:
                return nil
            }
        }
        collection.collectionViewLayout = layout
    }

}
