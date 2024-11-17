////
////  LargeLocationView.swift
////  Explore
////  Created by Developer on 5/20/24.
////
//
//import SwiftUI
//
////struct LargeLocationView: View {
////    @State var model: Model
////    @Binding var location: Location?
////    
////    @State private var scrollPosition: CGPoint = .zero
////    
////    var body: some View {
////        if location == nil { // improve later
////            
////        } else {
////            
////            ZStack(alignment: .top) {
////                
////                NavigationView {
////                    
////                    ScrollView {
////                        VStack(alignment: .leading) {
////                            
////                            TabView {
////                                Image(location!.image[0])
////                                    .resizable()
////                                    .aspectRatio(contentMode: .fill)
////                                    .tag(2)
////                                Image(location!.image[1])
////                                    .resizable()
////                                    .aspectRatio(contentMode: .fill)
////                                    .tag(1)
////                            }
////                            .frame(
////                                height: scrollPosition.y <= 0 ? 320 : 320 + (scrollPosition.y),
////                                alignment: .top)
////                            .tabViewStyle(.page(indexDisplayMode: .always))
////                            .padding(.horizontal, -20)
////                            .offset(y: scrollPosition.y < 0 ? 0 : -scrollPosition.y)
////                            
////                            
////                            Text(location!.name)
////                                .font(.largeTitle)
////                                .fontWeight(.bold)
////                            
////                            HStack {
////                                Text("12.3 miles")
////                                    .fontWeight(.medium)
////                                    .font(.subheadline)
////                                    .fontDesign(.rounded)
////                                Text("•")
////                                    .padding(.horizontal, -4)
////                                Text(location!.city)
////                                    .font(.subheadline)
////                                    .foregroundStyle(.secondary)
////                            }
////                            .padding(.bottom, 8)
////                            
////                            Text("About")
////                                .fontWeight(.medium)
////                            Text(location!.description)
////                                .frame(maxWidth: .infinity)
////                                .lineLimit(5)
////                                .padding()
////                                .background(.bar)
////                                .cornerRadius(12)
////                                .background(
////                                    RoundedRectangle(cornerRadius: 12)
////                                        .stroke(Color.white.opacity(0.2), lineWidth: 1.0)                        )
////                                .padding(.bottom, 24)
////                            
////                            Text("Ratings")
////                                .fontWeight(.medium)
////                            VStack(alignment: .leading) {
////                                RatingType(ratingType: "Scenic Beauty")
////                                Divider().padding(.horizontal, -16)
////                                
////                                RatingType(ratingType: "Accesibility")
////                                
////                                Divider().padding(.horizontal, -16)
////                                RatingType(ratingType: "Popularity")
////                            }
////                            .padding(.horizontal)
////                            .padding(.vertical, 8)
////                            .background(.bar)
////                            .cornerRadius(12)
////                            .background(
////                                RoundedRectangle(cornerRadius: 12)
////                                    .stroke(Color.white.opacity(0.2), lineWidth: 1.0)                        )
////                            .padding(.bottom, 8)
////                            
////                            Text("Leave Review")
////                                .foregroundStyle(.green)
////                                .font(.subheadline)
////                                .fontWeight(.medium)
////                                .fontDesign(.rounded)
////                                .foregroundStyle(.black)
////                                .padding(.horizontal, 24)
////                                .padding(.vertical, 10)
////                                .background(RoundedRectangle(cornerRadius: 32).foregroundStyle(.green.quinary))
////                                .padding(.bottom, 24)
////                                .padding(.horizontal, 88)
////                                .frame(maxWidth: .infinity, alignment: .center)
////                            
////                            
////                            Text("Conditions")
////                                .fontWeight(.medium)
////                            HStack {
////                                VStack(alignment: .leading) {
////                                    HStack {
////                                        Text("63º")
////                                            .font(.largeTitle)
////                                            .fontWeight(.medium)
////                                        Image(systemName: "sun.max")
////                                            .font(.title3)
////                                            .fontWeight(.bold)
////                                            .foregroundStyle(.yellow)
////                                    }
////                                    Text("Partly Cloudy")
////                                        .font(.callout)
////                                        .fontWeight(.medium)
////                                        .fontDesign(.rounded)
////                                        .foregroundStyle(.secondary)
////                                }
////                                .frame(maxWidth: .infinity)
////                                .padding()
////                                .background(.bar)
////                                .cornerRadius(12)
////                                .padding(.bottom)
////                                .lineLimit(4)
////                                
////                                VStack(alignment: .leading) {
////                                    HStack {
////                                        Text("15%")
////                                            .font(.largeTitle)
////                                            .fontWeight(.medium)
////                                        Image(systemName: "cloud.rain")
////                                            .font(.title3)
////                                            .fontWeight(.bold)
////                                            .foregroundStyle(.teal)
////                                    }
////                                    Text("chance of rain")
////                                        .font(.callout)
////                                        .fontWeight(.medium)
////                                        .fontDesign(.rounded)
////                                        .foregroundStyle(.secondary)
////                                }
////                                .frame(maxWidth: .infinity)
////                                .padding()
////                                .background(.bar)
////                                .cornerRadius(12)
////                                .padding(.bottom)
////                                .lineLimit(4)
////                            }
////                            
////                            Divider().foregroundStyle(.green.secondary)
////                            Text("Directions")
////                                .foregroundStyle(.green)
////                                .padding(.vertical, 8)
////                            Divider().foregroundStyle(.green.secondary)
////                            
////                            Text("More")
////                            
////                            
////                        }
////                        .padding(.horizontal, 20)
////                        .background(GeometryReader { geometry in
////                            Color.clear
////                                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
////                        })
////                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
////                            self.scrollPosition = value
////                            if scrollPosition.y > 100 && scrollPosition.y < 102 {
////                                lightHaptic()
////                            }
////                            if scrollPosition.y > 200 {
////                                model.view.showLocation = false
////                                model.selectedLocation = nil
////                                lightHaptic()
////                            }
////                        }
////                    }
////                    .scrollIndicators(.hidden)
////                    .coordinateSpace(name: "scroll")
////                    .edgesIgnoringSafeArea(.top)
////                    .toolbar {
////                        ToolbarItem(placement: .bottomBar) {
////                            HStack {
////                                VStack {
////                                    Image(systemName: "checkmark.circle")
////                                        .font(.callout)
////                                        .fontWeight(.medium)
////                                        .padding(.bottom, 1)
////                                    Text("Visited")
////                                        .font(.caption2)
////                                        .fontWeight(.semibold)
////                                }
////                                //                        .frame(height: 48)
////                                .foregroundStyle(.white)
////                                .frame(maxWidth: 48, alignment: .leading)
////                                
////                                //                        .padding(.vertical, 12)
////                                //                        .frame(maxWidth: .infinity)
////                                //                        .background(.green)
////                                //                        .cornerRadius(20)
////                                
////                                Spacer()
////                                
////                                VStack {
////                                    Image(systemName: location!.favorited ? "bookmark.fill" : "bookmark")
////                                        .font(.callout)
////                                        .fontWeight(.medium)
////                                        .padding(.bottom, 1)
////                                    Text("Favorite")
////                                        .font(.caption2)
////                                        .fontWeight(.semibold)
////                                        .fontDesign(.rounded)
////                                }
////                                .frame(height: 32)
////                                .foregroundStyle(.green)
//////                                .padding(.vertical, 12)
//////                                .padding(.horizontal, 20)
//////                                .background(.green)
//////                                .cornerRadius(20)
////                                .frame(maxWidth: .infinity, alignment: .center)
////                                
////                                Spacer()
////                                
////                                VStack {
////                                    Image(systemName: "square.and.arrow.up")
////                                        .font(.callout)
////                                        .fontWeight(.medium)
////                                        .padding(.bottom, 1)
////                                    Text("Share")
////                                        .font(.caption2)
////                                        .fontWeight(.semibold)
////                                }
////                                .frame(height: 32)
////                                .foregroundStyle(.white)
////                                .frame(maxWidth: 48, alignment: .trailing)
////                                //                        .padding(.vertical, 12)
////                                //                        .frame(maxWidth: .infinity)
////                                //                        .background(.bar)
////                                //                        .cornerRadius(20)
////                                
////                            }
////                            .padding(.top)
////                            .padding(.horizontal, 24)
////                        }
////                    }
////                }
////                
////                HStack {
////                    
////                        Text(location!.name)
////                            .font(.title3)
////                            .fontWeight(.bold)
////                            .opacity(scrollPosition.y < -280.0 ? 1.0 : 0.0)
////                            .animation(.default, value: scrollPosition)
////
////                    Spacer()
////                    
////                    Button {
////                        model.view.showLocation = false
////                        model.selectedLocation = nil
////                    } label: {
////                        Image(systemName: "xmark")
////                            .foregroundStyle(.white.secondary)
////                            .fontWeight(.bold)
////                            .padding(8)
////                            .background(Circle().foregroundStyle(.ultraThinMaterial))
////                            .scaleEffect(scrollPosition.y < 20 ? 1.0 : 1.3)
////                            .animation(.default, value: scrollPosition)
////                    }
////                }
////                .padding(.horizontal, 20)
////                .padding(.bottom, 24)
////                    .frame(maxWidth: .infinity, maxHeight: 32)
////                    .background(
////                        .black.opacity(
////                            scrollPosition.y >= 0 ? 0.0 : (1.0 * (-scrollPosition.y / 240))
////                        )
////                    )
////                
////            }
////            .frame(maxHeight: .infinity, alignment: .top)
////            
////        }
////        
////    }
////}
////
////#Preview {
////    LargeLocationView(model: Model(), location: .constant(locations[2]))
////}
//
//
//struct ScrollOffsetPreferenceKey: PreferenceKey {
//    static var defaultValue: CGPoint = .zero
//    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
//    }
//}
