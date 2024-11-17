//
//  Model.swift
//  Explore
//  Created by Nate Tedesco on 10/8/23.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

@Observable class Model {
    var view = ViewModel()
    var location = LocationManager()
    var settings = Settings()
    
    // Search
    var shownLocations: [Location]?
    var selectedTag: String? { didSet { filterLocations(in: location.lastSavedCameraPosition.region) }}
    var search: String = ""
    
    var selectedLocation: Location?
    var selectedImage: UIImage?
    var description: String = ""
    var images: [UIImage]?
    
    var favoriteLocations: [Location] = []
    var visitedLocations: [Location] = []

    init() {
        filterLocations(in: location.cameraPosition.region)
        loadLocations()
    }
    
    func save() {
        if let favoriteData = try? JSONEncoder().encode(favoriteLocations) {
            UserDefaults.standard.set(favoriteData, forKey: "favoriteLocations")
            print("Favorite locations saved: \(favoriteLocations)")
        }
        if let visitedData = try? JSONEncoder().encode(visitedLocations) {
            UserDefaults.standard.set(visitedData, forKey: "visitedLocations")
            print("Visited locations saved: \(visitedLocations)")
        }
    }

    func loadLocations() {
        if let data = UserDefaults.standard.data(forKey: "favoriteLocations"),
           let decoded = try? JSONDecoder().decode([Location].self, from: data) {
            self.favoriteLocations = decoded
            print("Favorite locations loaded: \(favoriteLocations)")
        }
        if let data = UserDefaults.standard.data(forKey: "visitedLocations"),
           let decoded = try? JSONDecoder().decode([Location].self, from: data) {
            self.visitedLocations = decoded
            print("Visited locations loaded: \(visitedLocations)")
        }
    }
    
    func filterLocations(in region: MKCoordinateRegion?) {
        self.location.lastSavedCameraPosition = .region(region!)
        
        if let selectedTag = selectedTag {
            shownLocations = locations.filter { location in
                return location.tags.contains(selectedTag)
            }
            self.search = selectedTag
        } else {
            shownLocations = locations
        }
        
        guard let shownLocations = shownLocations else { return }
        
        let mapRect = createMapRect(region: region!, regionSize: 1.5)
        let zoom = region!.span.latitudeDelta
        
        self.shownLocations = shownLocations.filter { location in
            let mapPoint = MKMapPoint(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            return mapRect.contains(mapPoint)
        }
        
        
        
        let maxPriority: Int
        if zoom >= 9 {
            maxPriority = selectedTag != nil ? 3 : 1
        } else if zoom >= 6 {
            maxPriority = selectedTag != nil ? 4 : 2
        } else if zoom >= 4 {
            maxPriority = selectedTag != nil ? 5 : 3
        } else if zoom >= 2 {
            maxPriority = selectedTag != nil ? 6 : 4
        } else if zoom >= 0.5 {
            maxPriority = selectedTag != nil ? 7 : 5
        } else if zoom >= 0.25 {
            maxPriority = selectedTag != nil ? 8 : 6
        } else if zoom >= 0.15 {
            maxPriority = selectedTag != nil ? 9 : 7
        } else {
            maxPriority = Int.max
        }
        
        self.shownLocations = shownLocations.filter { $0.priority <= maxPriority }
        
        //        print("Latitude span: \(region.span.latitudeDelta)")
        //        print("Longitude span: \(region.span.longitudeDelta)")
    }
    
    
    
    func createMapRect(region: MKCoordinateRegion, regionSize: Double) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/regionSize), longitude: region.center.longitude - (region.span.longitudeDelta/regionSize))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/regionSize), longitude: region.center.longitude + (region.span.longitudeDelta/regionSize))
        
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        
        let mapRect = MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
        
        return mapRect
    }
    
    func selectLocation(location: Location) {
        selectedLocation = nil
        images = nil
        selectedImage = nil
        selectedLocation = location
        view.showLocation = true
        if selectedLocation!.isExample {
            
            // better example management later
            self.description = "Big Sur is a stunning coastal region in California, known for its dramatic cliffs, pristine beaches, and lush forests. With its rugged terrain and breathtaking views of the Pacific Ocean, Big Sur offers a unique blend of natural beauty and serenity, making it a popular destination for outdoor enthusiasts and nature lovers alike."
            self.images =  [UIImage(named: "Big Sur")!, UIImage(named: "Big Sur 2")!, UIImage(named: "Big Sur 3")!]
            
        } else {
            loadDescription(location: location)
        }
        self.location.zoomToLocation(location: location)
        lightHaptic()
    }
    
    
    func dismissLocationView() {
        view.showLocation = false
        selectedLocation = nil
        images = nil
        selectedImage = nil
        description = "" // make nil
        location.unZoom()
        lightHaptic()
    }
    
    func calculateDistance(from: CLLocationCoordinate2D?, to: CLLocationCoordinate2D) -> String {
        guard let from = from else { return "0.0" }
        
        let fromLocation = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let toLocation = CLLocation(latitude: to.latitude, longitude: to.longitude)
        
        let distanceInMeters = fromLocation.distance(from: toLocation)
        let distanceInMiles = distanceInMeters / 1609.344
        let formattedDistance = String(format: "%.0f", distanceInMiles)

        return String("\(formattedDistance) miles away ")
        
    }
}
