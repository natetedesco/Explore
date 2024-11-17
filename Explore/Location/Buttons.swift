//
//  LocationButtons.swift
//  Explore
//
//  Created by Developer on 5/21/24.
//

import SwiftUI

struct LocationButtons: View {
    @State var model: Model
    @State var location: Location
    
    var body: some View {
        HStack(spacing: 12) {
            
            Button {
                saveToFavorites(location: location)
                lightHaptic()
            } label: {
                VStack {
                    Image(systemName: StorageService.shared.favoriteLocations.contains(location) ? "bookmark.fill" : "bookmark")
                        .font(.title3)
                        .fontWeight(.medium)
                    Text(StorageService.shared.favoriteLocations.contains(location) ? "favorited" : "favorite")
                        .font(.caption2)
                        .fontWeight(.semibold)
                }
                .frame(height: 32)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.green)
                .cornerRadius(20)
            }
            VStack {
                
                Button {
                    saveToVisited(location: location)
                } label: {
                    Image(systemName: StorageService.shared.visitedLocations.contains(location) ? "checkmark.circle.fill" : "checkmark.circle") // fill if visited
                        .font(.title3)
                        .fontWeight(.medium)
                    Text("Visited")
                        .font(.caption2)
                        .fontWeight(.semibold)
                }
            }
            .frame(height: 32)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.bar)
            .cornerRadius(20)
            
            VStack {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.title3)
                    .fontWeight(.medium)
                Text("Share")
                    .font(.caption2)
                    .fontWeight(.semibold)
            }
            .frame(height: 32)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(.bar)
            .cornerRadius(20)
        }
    }
    
    func saveToFavorites(location: Location) {
        if StorageService.shared.favoriteLocations.contains(location) {
            StorageService.shared.favoriteLocations.removeAll(where: { $0 == location })
        } else {
            StorageService.shared.favoriteLocations.append(Location(id: location.id, name: location.name, location: location.location, priority: location.priority, latitude: location.latitude, longitude: location.longitude))
        }
        StorageService.shared.save()
    }
    
    func saveToVisited(location: Location) {
        if StorageService.shared.visitedLocations.contains(location) {
            StorageService.shared.visitedLocations.removeAll(where: { $0 == location })
        } else {
            StorageService.shared.visitedLocations.append(Location(id: location.id, name: location.name, location: location.location, priority: location.priority, latitude: location.latitude, longitude: location.longitude))
        }
        StorageService.shared.save()
    }
}

//#Preview {
//    ZStack{}
//        .sheet(isPresented: .constant(true)) {
//            LocationView(model: Model(), location: locations[0])
//                .presentationDetents([.large])
//        }
//}
