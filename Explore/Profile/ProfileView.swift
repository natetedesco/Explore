//
//  ProfileView.swift
//  Explore
//  Created by Developer on 5/14/24.
//

import SwiftUI

struct ProfileView: View {
    @State var model: Model
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TopProfileBar(show: $model.showProfile)
                .padding(.bottom)
            
            HStack(spacing: 48) {
                TabButton(title: "FAVORITED", toggle: $model.ProfileViewOption, value: 0)
                TabButton(title: "VISITED", toggle: $model.ProfileViewOption, value: 1)
//                TabButton(title: "TRIPS", toggle: $toggle, value: 2) //
            }
            .padding(.bottom, 8)
            
            Divider()
                .padding(.horizontal, -20)
            
            if model.ProfileViewOption == 0 {
                FavoriteLocations(model: model)
            }
            
            if model.ProfileViewOption == 1 {
                VisitedLocations(model: model)
//                    ExplorePassport()
//                        .padding(.top)
            }
            
            if model.ProfileViewOption == 2 {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Create a Trip")
                        .fontWeight(.semibold)
                        .padding()
                        .background(LinearGradient(colors: [.green, .green.opacity(0.7)], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .cornerRadius(20)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 40)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .background()
        // Location
//        .sheet(item: $model.selectedLocation) { $location in
//            LocationView(model: model, location: $location)
//                .sheetMaterial()
//                .interactiveDismissDisabled()
//                .presentationDetents([.fraction(999/1000), .fraction(1/6), .fraction(4/10)], selection: .constant(PresentationDetent.fraction(4/10)))
//                .presentationBackgroundInteraction(.enabled(upThrough: .fraction(4/10)))
//        }
    }
}

#Preview {
    ZStack {}
        .sheet(isPresented: .constant(true)) {
            ProfileView(model: Model())
                .sheetMaterial()
                .presentationDetents([.medium])
        }
}

struct FavoriteLocations: View {
    @State var model: Model
    
    var body: some View {
        List {
            ForEach(StorageService.shared.favoriteLocations) { location in
                Button {
                    model.selectLocation(location)
                } label : {
                    LocationListView(location: location)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80)
        .padding(.horizontal, -20)
        .padding(.top, -8)
    }
    func delete(at offsets: IndexSet) {
        StorageService.shared.favoriteLocations.remove(atOffsets: offsets)
        StorageService.shared.save()
        }
}

struct VisitedLocations: View {
    @State var model: Model
    
    var body: some View {
        List {
            ForEach(StorageService.shared.visitedLocations) { location in
                Button {
                    model.selectLocation(location)
                } label : {
                    LocationListView(location: location)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 80)
        .padding(.horizontal, -20)
        .padding(.top, -8)
    }
    func delete(at offsets: IndexSet) {
        StorageService.shared.visitedLocations.remove(atOffsets: offsets)
        StorageService.shared.save()
        }
}


struct LocationListView: View {
    @State var location: Location
    
    var body: some View {
        HStack {
            // save this image to the user
            Image(location.name)
                .resizable()
                .frame(width: 64, height: 64)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(location.name)
                    .fontWeight(.semibold)
                HStack {
                    Text(location.location)
                        .font(.footnote)
                        .fontDesign(.rounded)
                        .foregroundStyle(.secondary)
                    Text("12.3 miles away")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundStyle(.tertiary)
                }
            }
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.subheadline)
                .foregroundStyle(.tertiary)
                .fontWeight(.semibold)
            
        }
        .listRowBackground(Color.clear)
    }
}
