//
//  Annotation.swift
//  Explore
//  Created by Developer on 5/19/24.
//

import SwiftUI

struct CustomAnnotation: View {
    @State var model: Model
    @State var location: Location
    
    var body: some View {
        VStack {
            if location.priority == 1 || location.priority == 2 {
                
                Image(location.name)
                    .resizable()
                    .frame(
                        width: model.selectedLocation == location ? 36 : 24,
                        height: model.selectedLocation == location ? 36 : 24
                    )
                    .scaledToFit()
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                
            } else {
                
                
                Image(systemName: "mountain.2.fill")
                    .font(.system(size: 7))
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.black)
                    .padding(model.selectedLocation == location ? 13 : 8)
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
        .opacity(model.shownLocations?.contains(location) ?? false ? 1.0 : 0.0)
        .animation(.default, value: model.selectedLocation)
        .onTapGesture {
            model.selectLocation(location: location)
        }
    }
}

struct CustomAnnotation2: View {
    @State var model: Model
    @State var location: Location
    
    var body: some View {
        Image(location.name)
            .resizable()
            .frame(
                width: model.selectedLocation == location ? 36 : 24,
                height: model.selectedLocation == location ? 36 : 24
            )
            .scaledToFit()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 1))
            .shadow(radius: 10)
            .animation(.default, value: model.selectedLocation)
    }
}
