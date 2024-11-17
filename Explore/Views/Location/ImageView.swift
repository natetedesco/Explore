//
//  ImageView.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI

struct ImageView: View {
    @State var model: Model
    @State var image: UIImage?
    @State var rotate = false
    
    var body: some View {
        ZStack {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(degrees: rotate ? 90 : 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            Button {
                rotate.toggle()
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 2)
                    .padding()
                    .background(Circle().foregroundStyle(.ultraThickMaterial))
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .background(.black)
        .frame(maxHeight: .infinity)
        .onTapGesture {
            model.view.showImage = false
            withAnimation {
                model.selectedImage = nil
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    model.view.showImage = false
                    withAnimation {
                        model.selectedImage = nil
                    }
                }
                .onEnded { _ in }
        )
    }
}

//#Preview {
//    ImageView(model: Model(), image: locations[2].image[0])
//}
