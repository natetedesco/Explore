//
//  LocationView.swift
//  Explore
//  Created by Developer on 5/14/24.
//

// Add visits

import SwiftUI

struct LocationView: View {
    @State var model: Model
    @Binding var location: Location?
    @State private var isExpanded: Bool = false
    
    
    var body: some View {
        if let location = location {
            
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        // Header
                        LocationHeader(model: model, location: $location)
                            .padding(.top, -24)
                            .padding(.bottom, 8)
                        
                        // Buttons
                        LocationButtons(model: model, location: location)
                            .padding(.bottom, 8)
                        
                        // Images
                        LocationImages(model: model, location: $location)
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
                .background()
            }
            .fullScreenCover(isPresented: $model.view.showImage) {
                ImageView(model: model, image: model.selectedImage)
                    .presentationBackground(.ultraThickMaterial)
                    .presentationCornerRadius(60)
            }
            .sheet(isPresented: $model.view.showLeaveReview) {
                ReviewView()
                    .presentationDetents([.fraction(9999/10000)])
            }
        }
    }
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
            LocationView(model: Model(), location: .constant(locations[0]))
                .presentationDetents([.fraction(999/1000)])
        }
}

struct Description: View {
    @State var model: Model
    @State var expanded: Bool = false
    @State var truncated: Bool = false
    @State var shrinkText: String
    @Binding var location: Location?
    
    let lineLimit = 5
    let font: UIFont
    
    init(model: Model, location: Binding<Location?>, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self._location = location
        self.model = model
        self._shrinkText = State(wrappedValue: model.description)
        self.font = font
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(expanded ? (model.description) : shrinkText) +
                Text(expanded ? "" : truncated ? "..." : "") +
                Text(moreLessText)
                    .foregroundStyle(.green)
            }
            .animation(.easeInOut(duration: 1.0), value: false)
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(model.description)
                    .lineLimit(lineLimit)
                    .background(GeometryReader { visibleTextGeometry in
                        Color.clear.onAppear() {
                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
                            
                            // Binary search until mid == low && mid == high
                            var low = 0
                            var heigh = shrinkText.count
                            var mid = heigh // start from top so that if text contains we do not need to loop
                            
                            while (heigh - low) > 1 {
                                let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                    truncated = true
                                    heigh = mid
                                    mid = (heigh + low) / 2
                                } else {
                                    if mid == model.description.count ?? 0 {
                                        break
                                    } else {
                                        low = mid
                                        mid = (low + heigh) / 2
                                    }
                                }
                                shrinkText = String((model.description ?? "").prefix(mid))
                            }
                            
                            if truncated {
                                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  // -2 extra as highlighted text is bold
                            }
                        }
                    })
                    .hidden() // Hide the background
            )
            .font(Font(font)) // set default font
            
            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack { // taking tap on only last line, as it is not possible to get 'see more' location
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
        .onChange(of: model.description) { newDescription in
            updateShrinkText(with: newDescription)
        }
    }
    
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "" : "  more"
        }
    }
    
    private func updateShrinkText(with newDescription: String?) {
        guard let description = newDescription else {
            shrinkText = ""
            return
        }
        let size = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        
        // Binary search until mid == low && mid == high
        var low = 0
        var heigh = description.count
        var mid = heigh
        
        while (heigh - low) > 1 {
            let attributedText = NSAttributedString(string: String(description.prefix(mid)) + moreLessText, attributes: attributes)
            let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            if boundingRect.size.height > CGFloat(lineLimit) * font.lineHeight {
                truncated = true
                heigh = mid
                mid = (heigh + low) / 2
            } else {
                low = mid
                mid = (low + heigh) / 2
            }
        }
        
        shrinkText = String(description.prefix(mid))
        if truncated {
            if shrinkText.count >= 2 {
                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  // -2 extra as highlighted text is bold
            } else {
                shrinkText = ""  // or handle this case as appropriate for your use case
            }
        }
    }
}


