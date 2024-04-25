//
//  File.swift
//  SportSpot
//
//  Created by rwan elmtary on 25/04/2024.
//

import Foundation
extension Date {
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
}
