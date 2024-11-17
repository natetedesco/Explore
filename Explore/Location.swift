//
//  LocationManager.swift
//  Explore
//  Created by Developer on 5/30/24.
//

import MapKit
import SwiftUI

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?

    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.0, longitude: -119.8),
            span: MKCoordinateSpan(latitudeDelta: 11.0, longitudeDelta: 11.0))
    ) { didSet { lastSavedCameraPosition = cameraPosition }}
    
    // regular cameraPosition is nill while screen is moving
    var lastSavedCameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.0, longitude: -119.8),
            span: MKCoordinateSpan(latitudeDelta: 11.0, longitudeDelta: 11.0))
    )
    
    var savedCameraPosition: MapCameraPosition?
    var zoomLevel = 1.0

    
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
        if savedCameraPosition == nil {
            self.savedCameraPosition = lastSavedCameraPosition
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
        if let savedCameraPosition = savedCameraPosition {
            self.cameraPosition = savedCameraPosition
        }
        savedCameraPosition = nil
        self.cameraPosition = cameraPosition
    }
}
