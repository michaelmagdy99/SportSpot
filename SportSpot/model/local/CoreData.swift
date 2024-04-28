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
    
    static func deleteFavoriteLeague(leagueKey: Int) {
        let fetchRequest = NSFetchRequest<FavLeagues>(entityName: "FavLeagues")
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", leagueKey)
        
        do {
            let leagues = try context.fetch(fetchRequest)
            for league in leagues {
                context.delete(league)
            }
            try context.save()
            print("League with key \(leagueKey) deleted successfully.")
        } catch {
            print("Error deleting league with key \(leagueKey): \(error.localizedDescription)")
        }
    }


    
}
