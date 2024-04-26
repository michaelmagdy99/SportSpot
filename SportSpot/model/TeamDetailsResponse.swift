//
//  TeamDetailsResponse.swift
//  SportSpot
//
//  Created by Michael Magdy on 27/04/2024.
//

import Foundation

struct TeamDetailsResponse : Codable{
    let success: Int?
    let result: [TeamDetailsModel]?
}

struct TeamDetailsModel :Codable{
    
}
