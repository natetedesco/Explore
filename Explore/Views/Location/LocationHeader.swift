//
//  LocationHeader.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI
import MapKit

struct LocationHeader: View {
    @State var model: Model
    @Binding var location: Location?
    
    var body: some View {
        HStack {
            Text(location?.location ?? "")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .fontDesign(.rounded)
            Text("•")
                .foregroundStyle(.tertiary)
                .padding(.horizontal, -4)
            Text(model.calculateDistance(
                from: CLLocationCoordinate2D(latitude: model.location.userLocation?.latitude ?? 0.0,
                                             longitude: model.location.userLocation?.longitude ?? 0.0),
                to: CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)))
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
