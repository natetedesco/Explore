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
            VStack {
                
                // User Location
                Button {
                    lightHaptic()
                    withAnimation {
                        if let userLocation = model.location.userLocation {
                            model.location.cameraPosition = .region(
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
                    model.view.showMapSettings.toggle()
                } label: {
                    Image(systemName: "map.fill")
                        .font(.callout)
                        .padding(.top, 4)
                        .padding(.bottom, 16)
                }
            }
            .padding(.horizontal, 8)
            .background(.bar)
            .background(.black.opacity(0.8))
            .cornerRadius(20)
            .padding(.trailing, 8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.top, 8)
            .opacity(model.view.detent == .fraction(999/1000) ? 0.0 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: model.view.detent)
            
        }
    }
}

#Preview {
    ContentView(model: Model())
}
