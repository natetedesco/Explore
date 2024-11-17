//
//  SearchComponents.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI

// Filter Button
struct FilterButton: View {
    @State var model: Model
    @State var tag: String
    @State private var width: CGFloat = 0
    
    var body: some View {
        Button {
            withAnimation {
                model.view.showResults = true
                model.selectedTag = tag
            }
            lightHaptic()
        } label: {
            VStack {
                Image(systemName: "")
                    .font(.callout)
                    .foregroundStyle(model.selectedTag == tag ? Color.green.opacity(0.8) : .secondary)
                
                Text(tag)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(model.selectedTag == tag ? Color.green.opacity(0.8) : .secondary)
                    .fontWeight(.medium)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        }
                    )
                
                
                Rectangle()
                    .frame(width: width)
                    .foregroundStyle(.green.opacity(0.8))
                    .cornerRadius(4)
                    .frame(height: 2)
                    .padding(.top, -6)
                    .opacity(model.selectedTag == tag ? 1 : 0)
            }
    }
    .onPreferenceChange(WidthPreferenceKey.self) { value in
        width = value
    }
    .animation(.default, value: model.selectedTag)
        .padding(.horizontal, 10)
    }
}

// Search Filter Button
struct SearchFilterButton: View {
    @State var model: Model
    @State var text: String
    @State var icon: String
    
    var body: some View {
        Button {
            
        } label: {
            Text(text)
                .font(.system(size: 14))
                .fontDesign(.rounded)
            Image(systemName: icon)
                .font(.caption2)
                .fontWeight(.semibold)
        }
        .padding(8)
        .background(
            Capsule()
                .strokeBorder(Color.green.secondary,lineWidth: 0.8)
                .background(Color.clear)
                .clipped()
        )
        .clipShape(Capsule())
    }
}

// No Search Text
struct NoSearchText: View {
    @State var text: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(text)
                .fontDesign(.rounded)
                .foregroundStyle(.tertiary)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
}
