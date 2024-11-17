//
//  ContentViewComponents.swift
//  Explore
//  Created by Developer on 5/21/24.
//

import SwiftUI

// Logo
struct AppleMapsLogo: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: "apple.logo")
                .font(.footnote)
                .padding(.trailing, -6)
                .padding(.bottom, 3)
            Text("Maps")
                .font(.subheadline)
                .fontWeight(.medium)
                .fontDesign(.rounded)
            Link(destination: URL(string: "https://gspe21-ssl.ls.apple.com/html/attribution-279.html")!, label: {
                Text("Legal")
                    .foregroundStyle(.white.tertiary)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .underline()
                    .padding(.bottom, 1)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding(.bottom, 132)
        .padding(.leading)
    }
}

// Search this area
struct SearchThisArea: View {
    var body: some View {
        Text("search this area")
            .font(.caption)
            .fontDesign(.rounded)
            .foregroundStyle(.green)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.black.opacity(0.3))
            .background(.bar)
            .cornerRadius(20)
            .frame(maxHeight: .infinity, alignment: .top)
    }
}

