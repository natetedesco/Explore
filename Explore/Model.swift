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
    
    var search: String = ""
    var selectedTag: String? { didSet { filterLocations(location.lastSavedPosition.region) }}
    
    var shownLocations: [Location]?
    var selectedLocation: Location?
    
    init() { filterLocations(location.cameraPosition.region)}
    
    func selectLocation(_ location: Location) { lightHaptic()
        selectedLocation = nil
        selectedLocation = location
        view.showLocation = true
        loadData(location: location)
        self.location.zoomToLocation(location: location)
    }
    
    func loadData(location: Location) {
        Task {
            do {
                let result = try await APIService.shared.loadData(for: location)
                await MainActor.run {
                    self.selectedLocation?.description = result.description
                    self.selectedLocation?.images = result.imageUrls
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func dismissLocationView() { lightHaptic()
        view.showLocation = false
        selectedLocation = nil
        location.unZoom()
    }
    
    func filterLocations(_ region: MKCoordinateRegion?) {
        guard let region = region else { return }
        location.lastSavedPosition = .region(region)
        
        // First filter by tag
        var filtered = selectedTag != nil ?
        locations.filter { $0.tags.contains(selectedTag!) } :
        locations
        
        // Then filter by map bounds
        let mapRect = createMapRect(region: region, regionSize: 1.5)
        filtered = filtered.filter { location in
            let mapPoint = MKMapPoint(CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ))
            return mapRect.contains(mapPoint)
        }
        
        // Finally filter by zoom level priority
        let maxPriority = calculateMaxPriority(for: region.span.latitudeDelta)
        filtered = filtered.filter { $0.priority <= maxPriority }
        
        shownLocations = filtered
    }
    
    func calculateMaxPriority(for zoom: Double) -> Int {
        let hasTag = selectedTag != nil
        switch zoom {
        case ...0.15:  return Int.max
        case ...0.25:  return hasTag ? 9 : 7
        case ...0.5:   return hasTag ? 8 : 6
        case ...2:     return hasTag ? 7 : 5
        case ...4:     return hasTag ? 6 : 4
        case ...6:     return hasTag ? 5 : 3
        case ...9:     return hasTag ? 4 : 2
        default:       return hasTag ? 3 : 1
        }
    }
    
    func createMapRect(region: MKCoordinateRegion, regionSize: Double) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/regionSize), longitude: region.center.longitude - (region.span.longitudeDelta/regionSize))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/regionSize), longitude: region.center.longitude + (region.span.longitudeDelta/regionSize))
        
        let a = MKMapPoint(topLeft)
        let b = MKMapPoint(bottomRight)
        
        let mapRect = MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
        
        return mapRect
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

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?
    
    var zoomLevel = 1.0
    
    // regular cameraPosition is nill while screen is moving
    var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.0, longitude: -119.8),
        span: MKCoordinateSpan(latitudeDelta: 11.0, longitudeDelta: 11.0))
    ) { didSet { lastSavedPosition = cameraPosition }}
    var savedPosition: MapCameraPosition?
    var lastSavedPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.0, longitude: -119.8),
        span: MKCoordinateSpan(latitudeDelta: 11.0, longitudeDelta: 11.0))
    )
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            userLocation = location
            updateCameraPosition()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    func updateCameraPosition() {
        if let userLocation = userLocation {
            cameraPosition = .region(
                MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)) // link these
            )
        }
    }
    
    func zoomToLocation(location: Location) {
        if savedPosition == nil {
            self.savedPosition = lastSavedPosition
        }
        
        if zoomLevel > 1 {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)
            )
            
            let offsetLatitude = -0.25
            let offsetCenterCoordinate = CLLocationCoordinate2D(
                latitude: location.latitude + offsetLatitude,
                longitude: location.longitude
            )
            let offsetRegion = MKCoordinateRegion(center: offsetCenterCoordinate, span: region.span)
            self.cameraPosition = .region(offsetRegion)
        }
    }
    
    func unZoom() {
        if let savedPosition = savedPosition {
            self.cameraPosition = savedPosition
        }
        savedPosition = nil
        self.cameraPosition = cameraPosition
    }
}
