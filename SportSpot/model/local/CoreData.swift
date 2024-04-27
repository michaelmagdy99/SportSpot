import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let context: NSManagedObjectContext
    
    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error with context")
        }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveLeague(_ data: [String: Any]) {
        let league = FavLeagues(context: context)
        league.leagueKey = data["leagueKey"] as? Int16 ?? 0
        league.leagueName = data["leagueName"] as? String ?? ""
        league.leagueLogo = data["leagueLogo"] as? String ?? ""
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavoriteLeagues() -> [FavLeagues] {
        do {
            let favoriteLeagues = try context.fetch(FavLeagues.fetchRequest()) as? [FavLeagues] ?? []
            return favoriteLeagues
        } catch {
            print("Failed to fetch favorite leagues: \(error.localizedDescription)")
            return []
        }
    }
}
