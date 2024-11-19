//
//  SheetView.swift
//  Explore
//  Created by Nate Tedesco on 10/8/23.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State var model: Model
    
    var body: some View {
        
//        TabView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Top Bar
                SearchBar(model: model)
                
                // Search Filter Buttons
                ScrollView(.horizontal) {
                    HStack {
                        // Filter Buttons
                        ForEach(locationTags, id: \.self) { tag in
                            FilterButton(model: model, tag: tag)
                        }
                    }
                    .animation(.default, value: model.selectedTag)
                    .padding(.leading)
                }
                .padding(.horizontal, -16)
                .scrollIndicators(.hidden)
//                
                if model.detent == .fraction(4/10) && model.selectedTag == nil {
                    NoSearchText(text: "Search for a location or select a type of location to start exploring.")
                        .padding(.bottom, 56)
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .frame(maxHeight: .infinity, alignment: .top)
            .darkBackground()
            .onAppear {
                model.detent = .fraction(1/6)
            }
        
        // Profile
        .sheet(isPresented: $model.showProfile) {
            VStack {
                ProfileView(model: model)
            }
            .sheetMaterial()
            .presentationDetents([.fraction(999/1000), .fraction(5/10)])
            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(5/10)))
        }
        
        // Location
        .sheet(isPresented: $model.showLocation, onDismiss: {
            model.selectedLocation = nil
        }) {
            LocationView(model: model, location: Binding(
                get: { model.selectedLocation ?? exampleLocation },
                set: { model.selectedLocation = $0 }
            ))                .sheetMaterial()
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
                .presentationDetents([.fraction(999/1000), .fraction(1/6), .fraction(4/10)], selection: .constant(PresentationDetent.fraction(4/10)))
                .presentationBackgroundInteraction(.enabled(upThrough: .fraction(4/10)))
        }
        // Map Settings
        .sheet(isPresented: $model.showMapSettings) {
            MapSettingsView(model: model)
                .presentationDetents([.fraction(9999/10000)])
                .presentationBackgroundInteraction(.enabled(upThrough: .fraction(4/10)))
                .presentationCornerRadius(28)
                .presentationDragIndicator(.hidden)
                .accentColor(.green)
                .ignoresSafeArea()
        }
    }
}


#Preview {
    ZStack {}
        .sheet(isPresented: .constant(true)) {
            SearchView(model: Model())
                .sheetMaterial()
                .presentationDetents([.fraction(4/10), .fraction(999/1000)])
        }
}

