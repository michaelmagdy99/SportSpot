import Foundation
import CoreData
import UIKit

class CoreDataManager :CoreProtocol{
    
    
    static let shared = CoreDataManager()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = appDelegate.persistentContainer.viewContext
    static let entity = NSEntityDescription.entity(forEntityName: "FavLeagues", in: context)
    
    
    private init() {}
    
    static func saveLeague(league: LeagueModel, leagueType: String) {
        
        
        let leagues = NSManagedObject(entity: entity!, insertInto: context)
        leagues.setValue(league.league_key, forKey: "leagueKey")
        leagues.setValue(league.league_name, forKey: "leagueName")
        leagues.setValue(league.league_logo, forKey: "leagueLogo")
        //        leagues.setValue(league.country_key, forKey: "countryKey")
        //        leagues.setValue(league.country_name, forKey: "countryName")
        //        leagues.setValue(league.country_logo, forKey: "countryLogo")
        print(league.league_name as Any)
        
        do {
            try
            CoreDataManager.context.save()
            print("League saved to favorites successfully.")
        } catch {
            print("Error saving league to favorites: \(error.localizedDescription)")
        }
    }
    
    static func fetchFavoriteLeagues() -> [FavLeagues] {
        let fetchRequest = NSFetchRequest<FavLeagues>(entityName: "FavLeagues")
        
        do {
            let leagues = try context.fetch(fetchRequest)
            print(leagues.count)

            return leagues
        } catch {
            print("Failed to fetch favorite leagues: \(error.localizedDescription)")
            return []
        }
    }
    
    
    //func fetchData (){
    //    // 1- the place to access context
    //    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //
    //    // 2- get context
    //    context = appDelegate.persistentContainer.viewContext
    //
    //    // 3- fetch request
    //    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movie")
    //
    //    do {
    //        movies = try context?.fetch(fetchRequest) ?? []
    //
    //               tableView.reloadData()
    //           } catch let error as NSError {
    //               print(error.localizedDescription)
    //           }
    //
    
}
