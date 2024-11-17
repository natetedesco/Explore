//
//  Data.swift
//  Explore
//  Created by Developer on 5/14/24.
//

import Foundation
import MapKit
import SwiftUI

let locationTags = ["Scenic", "Beach", "Forest", "Coastal", "Lake", "River", "Waterfall", "Desert", "Mountain", "National Park", "Hot Spring", "Canyon", "Bay", "Hiking", "Volcano", "Geyser", "Tide Pools", "Sand Dunes", "Cave"]

struct Location: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var location: String
    var type: String?
    var tags: [String] = []
    var priority: Int
    var latitude: Double
    var longitude: Double
    
    var favorited = false
    var isExample = false
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
    
    








