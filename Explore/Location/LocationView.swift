//
//  LocationNew.swift
//  Explore
//  Created by Developer on 11/17/24.
//

import SwiftUI

struct LocationView: View {
    @State var model: Model
    @Binding var location: Location
    @State private var isExpanded: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // Header
                    LocationHeader(location: $location)
                        .padding(.top, -24)
                    
                    // Buttons
                    LocationButtons(location: location)
                        .padding(.bottom, 8)
//                        .padding(.top)
                    
                    //                     Images
                    LocationImages(location: $location)
                        .padding(.bottom, 24)
                    
                    Text("About")
                        .fontWeight(.semibold)
                    
                    Description(model: model, location: $location)
                        .padding(.vertical)
                        .padding(.horizontal, 12)
                        .background(.bar)
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                    
                    Text("Ratings & Reviews")
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        RatingType(ratingType: "Accesibility")
                        Divider()
                        RatingType(ratingType: "Popularity")
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(.bar)
                    .cornerRadius(16)
                    .padding(.bottom, 24)
                    
                    Text("Conditions")
                        .fontWeight(.semibold)
                    Conditions(location: $location)
                        .padding(.bottom, 24)
                    
                    Text("Information")
                        .fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Button {
                            let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                            let mapItem = MKMapItem(placemark: placemark)
                            mapItem.name = location.name
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                            MKMapItem.openMaps(with: [mapItem], launchOptions: launchOptions)
                        } label: {
                            HStack {
                                Image(systemName: "car.fill")
                                Text("Get Directions")
                                    .font(.callout)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        Divider()
                        
                        Button {
                            let urlStr = "x-web-search://?\(location.name) \(location.location)"
                            if let url = URL(string: urlStr) {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.open(url, options: [:]) { didEnd in
                                        print("Did End: \(didEnd)")
                                    }
                                } else {
                                    print("Can't open URL")
                                }
                            } else {
                                print("Isn't URL")
                            }
                        } label: {
                            
                            HStack {
                                Image(systemName: "safari")
                                Text("Search in browser")
                                    .font(.callout)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .background(.bar)
                    .cornerRadius(12)
                    .padding(.bottom, 24)
                    
                    Button {
                        
                    } label: {
                        Text("Leave Review")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(RoundedRectangle(cornerRadius: 24).foregroundStyle(.green.quinary))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom)
                    
                    Button {
                        
                    } label: {
                        Text("Suggest Edit")
                            .font(.footnote)
                            .foregroundStyle(.green.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    Spacer()
                }
                .padding(20)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text(location.name)
                            .font(location.name.count > 20 ? .title3 : .title)
                            .fontWeight(.bold)
                            .padding(.leading, 4)
                            .padding(.top, 8)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            model.dismissLocationView()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.footnote)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white.tertiary)
                                .padding(6)
                                .background(Circle().foregroundStyle(.ultraThinMaterial))
                        }
                        .padding(.top, 8)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .darkBackground()
        }
        .fullScreenCover(item: $model.selectedImage) { image in
            ImageView(model: model, image: image)
                .presentationBackground(.ultraThickMaterial)
                .presentationCornerRadius(60)
        }
        .sheet(isPresented: $model.showLeaveReview) {
            ReviewView()
                .presentationDetents([.fraction(9999/10000)])
        }
    }
}

struct ImageWrapper: Identifiable {
    let id = UUID()
    let uiImage: UIImage
}

struct RatingType: View {
    
    var ratingType: String
    var body: some View {
        HStack(alignment: .center) {
            Text(ratingType)
                .font(.callout)
            //                .foregroundStyle(.secondary)
            Spacer()
            HStack(spacing: 2) {
                ForEach(0..<5) {_ in
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
                //                Image(systemName: "chevron.right") // Disclosure group
                //                    .font(.footnote)
                //                    .fontWeight(.semibold)
                //                    .foregroundStyle(.tertiary)
                //                    .padding(.leading, 12)
            }
        }
        .padding(.vertical, 8)
    }
}

import MapKit

#Preview {
    Map()
        .sheet(isPresented: .constant(true)) {
            LocationView(model: Model(), location: .constant(exampleLocation))
                .presentationDetents([.fraction(999/1000)])
        }
}




