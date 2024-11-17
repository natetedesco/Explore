//
//  MapSettings.swift
//  Explore
//  Created by Developer on 5/18/24.
//

import SwiftUI

struct MapSettingsView: View {
    @State var model: Model
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Maps")) {
                    Label("Map", systemImage: "map.fill")
                        .listRowBackground(Color.clear)
                    
                    // points of interest
                    
                    // map shows hiking
                }

                Section(header: Text("About")) {
                    Text("Send Feedback")
                        .listRowBackground(Color.clear)
                    
                    Text("About")
                        .listRowBackground(Color.clear)
                    
                    Text("Share Explore")
                        .listRowBackground(Color.clear)
                    
                    Text("Privacy & Terms")
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 64)
            .navigationTitle("Settings")
            .darkBackground()
            
        }
    }
}

#Preview {
    ZStack {}
        .sheet(isPresented: .constant(true)) {
            MapSettingsView(model: Model())
                .sheetMaterial()
                .presentationDetents([.large])
        }
}

struct ExampleView: View {
    var body: some View {
        ZStack {}
    }
}

//HStack {
//    Text("Map Type")
//    Spacer()
//
//    Menu {
//        Button {
//            model.map.mapStyle = .standard
//        } label: {
//            Text("Standard")
//        }
//
//        Button {
//            model.map.mapStyle = .hybrid
//        } label: {
//            Text("Hybrid")
//        }
//
//        Button {
//            model.map.mapStyle = .imagery
//        } label: {
//            Text("Satelite")
//        }
//    } label: {
//        Text("Standard")
//            .font(.subheadline)
//            .padding(.horizontal, 12)
//            .padding(.vertical, 8)
//            .background(.bar)
//            .cornerRadius(16)
//    }
//}
