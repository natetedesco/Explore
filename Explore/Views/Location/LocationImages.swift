//
//  LocationImages.swift
//  Explore
//
//  Created by Developer on 5/21/24.
//

import SwiftUI

struct LocationImages: View {
    @State var model: Model
    @Binding var location: Location?
    
    var body: some View {
        if let images = model.images {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 148)
                            .cornerRadius(20)
                            .onTapGesture {
                                withAnimation {
                                    model.selectedImage = image
                                    model.view.showImage = true
                                }
                            }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
            .scrollIndicators(.hidden)
            
        } else {
            ProgressView(label: {
                Text("Loading")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            )
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 148)
        }
    }
}

//#Preview {
//    ZStack{}
//        .sheet(isPresented: .constant(true)) {
//            LocationView(model: Model(), location: .constant(model.shownLocations[0]))
//                .presentationDetents([.large])
//        }
//}
