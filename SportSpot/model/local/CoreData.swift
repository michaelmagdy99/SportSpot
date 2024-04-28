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
    
    func fetchFavoriteLeagues(context: NSManagedObjectContext) -> [FavLeagues] {
        do {
            let favoriteLeagues = try context.fetch(FavLeagues.fetchRequest()) as? [FavLeagues] ?? []
            return favoriteLeagues
        } catch {
            print("Failed to fetch favorite leagues: \(error.localizedDescription)")
            return []
        }
    }
}
