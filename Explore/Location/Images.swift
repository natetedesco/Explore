//
//  LocationImages.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI

struct LocationImages: View {
    @Environment(Model.self) private var model
    @Binding var location: Location

    var body: some View {
        if let images = location.images {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(images, id: \.self) { imageURL in
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 148)
                                .cornerRadius(20)
                                .onTapGesture {
                                    withAnimation {
                                        model.selectedImage = ImageWrapper(uiImage: image.asUIImage()) // Pass the actual image instead of URL
//                                        model.showImage = true
                                    }
                                }
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.horizontal, -20)
            .scrollIndicators(.hidden)
        } else {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .frame(height: 148)
        }
    }
}

extension Image {
    func asUIImage() -> UIImage {
        // Convert SwiftUI Image to UIImage
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let renderer = UIGraphicsImageRenderer(bounds: view?.bounds ?? .zero)
        return renderer.image { _ in
            view?.drawHierarchy(in: view?.bounds ?? .zero, afterScreenUpdates: true)
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
