//
//  LocationHeader.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI
import MapKit

struct LocationHeader: View {
    @Environment(Model.self) private var model
    @Binding var location: Location
    
    var body: some View {
        HStack {
            Text(location.location)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fontDesign(.rounded)
            Text("•")
                .foregroundStyle(.tertiary)
                .padding(.horizontal, -4)
            Text(model.map.calculateDistance(
                from: CLLocationCoordinate2D(latitude: model.map.userLocation?.latitude ?? 0.0,
                                             longitude: model.map.userLocation?.longitude ?? 0.0),
                to: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)))
            .font(.footnote)
            .foregroundStyle(.tertiary)
            .fontDesign(.rounded)
        }
    }
}

//#Preview {
//    ZStack{}
//        .sheet(isPresented: .constant(true)) {
//            LocationView(model: Model(), location: .constant(model.shownLocations[0]))
//                .presentationDetents([.large])
//        }
//}
