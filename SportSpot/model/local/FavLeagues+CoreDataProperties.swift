//
//  FavLeagues+CoreDataProperties.swift
//  
//
//  Created by rwan elmtary on 27/04/2024.
//
//

import Foundation
import CoreData


extension FavLeagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavLeagues> {
        return NSFetchRequest<FavLeagues>(entityName: "FavLeagues")
    }

    @NSManaged public var countryKey: Int16
    @NSManaged public var countryLogo: String?
    @NSManaged public var countryName: String?
    @NSManaged public var leagueKey: Int16
    @NSManaged public var leagueLogo: String?
    @NSManaged public var leagueName: String?

}
