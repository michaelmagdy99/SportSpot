//
//  Response.swift
//  SportSpot
//
//  Created by Michael Magdy on 22/04/2024.
//

import Foundation

struct Response : Codable {
    let success: Int
    let result: [FootballResponse]
}
