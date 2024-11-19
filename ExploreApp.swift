//
//  ExploreApp.swift
//  Explore
//  Created by Nate Tedesco on 10/7/23.
//

import SwiftUI

@main struct ExploreApp: App {
    @State var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .environment(model)
                .accentColor(.green)
                .onAppear {
                    if model.map.locationManager.authorizationStatus == .notDetermined {
                        model.map.locationManager.requestWhenInUseAuthorization()
                    }
                }
        }
    }
}
