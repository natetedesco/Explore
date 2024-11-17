//
//  ExploreApp.swift
//  Explore
//  Created by Nate Tedesco on 10/7/23.
//

import SwiftUI

@main
struct ExploreApp: App {
    @State var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .accentColor(.green)
                .onAppear {
                    if model.location.locationManager.authorizationStatus == .notDetermined {
                        model.location.locationManager.requestWhenInUseAuthorization()
                    }
                }
        }
    }
}
