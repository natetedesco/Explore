//
//  LocationManager.swift
//  Explore
//  Created by Developer on 5/30/24.
//

import Foundation
import SwiftUI
import MapKit



@Observable class StorageService {
    static let shared = StorageService()
    var favoriteLocations: [Location] = []
    var visitedLocations: [Location] = []
    
    private init() {
        loadLocations()
    }
    
    private func loadLocations() {
        if let data = UserDefaults.standard.data(forKey: "favoriteLocations"),
           let locations = try? JSONDecoder().decode([Location].self, from: data) {
            self.favoriteLocations = locations
            print("Favorite locations loaded: \(locations)")
        }
        
        if let data = UserDefaults.standard.data(forKey: "visitedLocations"),
           let locations = try? JSONDecoder().decode([Location].self, from: data) {
            self.visitedLocations = locations
            print("Visited locations loaded: \(locations)")
        }
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(favoriteLocations) {
            UserDefaults.standard.set(data, forKey: "favoriteLocations")
            print("Favorite locations saved: \(favoriteLocations)")
        }
        if let data = try? JSONEncoder().encode(visitedLocations) {
            UserDefaults.standard.set(data, forKey: "visitedLocations")
            print("Visited locations saved: \(visitedLocations)")
        }
    }
}
