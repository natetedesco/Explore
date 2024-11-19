//
//  ContentView.swift
//  Explore
//  Created by Nate Tedesco on 10/7/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var model: Model
    
    var body: some View {
        ZStack {
            
            Map(position: $model.map.cameraPosition) {
                UserAnnotation()
                
                // Annotations
                ForEach(model.map.shownLocations ?? []) { location in
                    Annotation(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        VStack {
                            if UIImage(named: location.name) != nil {
                                Image(location.name)
                                    .resizable()
                                    .frame(
                                        width: model.selectedLocation == location ? 38 : 24,
                                        height: model.selectedLocation == location ? 38 : 24
                                    )
                                    .scaledToFit()
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                    .blur(radius: 0.11)
                                
                            } else {
                                Image(systemName: "mountain.2.fill")
                                    .font(.system(size: 7))
                                    .fontWeight(.ultraLight)
                                    .foregroundStyle(.black)
                                    .padding(model.selectedLocation == location ? 12 : 8)
                                    .scaleEffect(model.selectedLocation == location ? 1.4 : 1.0)
                                    .background (
                                        Circle()
                                            .strokeBorder(Color.black, lineWidth: 1.3)
                                            .background(
                                                RadialGradient(
                                                    gradient: Gradient(colors: [.green, .black]),
                                                    center: .center,
                                                    startRadius: 0,
                                                    endRadius: 56
                                                )
                                            )
                                            .clipped()
                                    )
                            }
                        }
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .opacity(model.map.shownLocations?.contains(location) ?? false ? 1.0 : 0.0)
                        .animation(.default, value: model.selectedLocation)
                        .onTapGesture { model.selectLocation(location) }
                    }
                }
            }
            .environment(\.colorScheme, model.mapColorScheme)
            .mapStyle(.standard(pointsOfInterest: .including([])))
            .accentColor(.green.opacity(0.8))
            .onMapCameraChange { map in
                withAnimation {
                    let region = map.region
                    model.map.filterLocations(region, tag: model.selectedTag)
                    model.map.zoomLevel = region.span.latitudeDelta
                }
            }
            
            // Logo & Controls
            AppleMapsLogo()
            
            MapControlButtons(model: model)
            
            if model.showSearchThisArea { SearchThisArea() }
        }
        .accentColor(.green.opacity(0.8))
        .animation(.bouncy(duration: 0.3), value: model.selectedLocation) // duplicating annotation scale animation here makes it work ;)
        .sheet(isPresented: .constant(true)) {
            SearchView(model: model)
                .sheetMaterial()
                .interactiveDismissDisabled()
                .presentationDetents([.large, .fraction(4/10), .fraction(1/6)], selection: $model.detent)
                .presentationBackgroundInteraction(.enabled)
        }
    }
}

#Preview {
    ContentView(model: Model())
}

