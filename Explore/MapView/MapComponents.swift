//
//  MapControlButtons.swift
//  Explore
//  Created by Developer on 5/19/24.
//

import SwiftUI
import MapKit

struct MapControlButtons: View {
    @State var model: Model
    
    var body: some View {
        VStack {
            // User Location
            Button {
                lightHaptic()
                withAnimation {
                    if let userLocation = model.map.userLocation {
                        model.map.cameraPosition = .region(
                            MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                        )
                    }
                }
            } label: {
                Image(systemName: "location.fill")
                    .font(.callout)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
            }
            
            Divider()
                .frame(maxWidth: 24)
            
            // Settings
            Button {
                lightHaptic()
                model.showMapSettings.toggle()
            } label: {
                Image(systemName: "map.fill")
                    .font(.callout)
                    .padding(.top, 4)
                    .padding(.bottom, 16)
            }
        }
        .padding(.horizontal, 8)
        .background(.bar)
        .background(.black.opacity(0.85))
        .cornerRadius(20)
        .padding(.trailing, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(.top, 8)
    }
}

// Logo
struct AppleMapsLogo: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: "apple.logo")
                .font(.footnote)
                .padding(.trailing, -6)
                .padding(.bottom, 3)
            Text("Maps")
                .font(.subheadline)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            Link(destination: URL(string: "https://gspe21-ssl.ls.apple.com/html/attribution-279.html")!, label: {
                Text("Legal")
                    .foregroundStyle(.white.tertiary)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.bottom, 1)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.bottom, 132)
        .padding(.leading)
    }
}

// Search this area
struct SearchThisArea: View {
    var body: some View {
        Text("search this area")
            .font(.caption)
            .fontDesign(.rounded)
            .foregroundStyle(.green)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.black.opacity(0.3))
            .background(.bar)
            .cornerRadius(20)
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView(model: Model())
}
