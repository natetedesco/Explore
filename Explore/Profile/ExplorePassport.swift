//
//  ExplorePassport.swift
//  Explore
//  Created by Developer on 5/18/24.
//

import SwiftUI

struct ExplorePassport: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("ALL-TIME EXPLORE PASSPORT")
                .fontWeight(.medium)
                .foregroundStyle(.green.opacity(1.0))
                .fontDesign(.monospaced)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("TRAVELED TO")
                        .font(.caption2)
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                    
                    Text("12")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.vertical, -12)
                    
                    Text("LOCATIONS")
                        .font(.footnote)
                        .foregroundStyle(.thickMaterial)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("TRAVEL")
                        .font(.caption2)
                        .foregroundStyle(.black)
                        .fontWeight(.medium)
                    
                    Text("1,690 mi")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                        .padding(.vertical, -12)
                    
                    Text("Distance")
                        .font(.footnote)
                        .foregroundStyle(.thickMaterial)
                        .fontWeight(.semibold)
                }
                
                Spacer()
//                
//                VStack(alignment: .leading) {
//                    Text("CREATED")
//                        .font(.caption2)
//                        .foregroundStyle(.black)
//                        .fontWeight(.medium)
//                    
//                    Text("8")
//                        .font(.system(size: 40))
//                        .fontWeight(.bold)
//                        .foregroundStyle(.black)
//                        .padding(.vertical, -12)
//                    
//                    Text("LOCATIONS")
//                        .font(.footnote)
//                        .foregroundStyle(.thickMaterial)
//                        .fontWeight(.semibold)
//                }
            }
            .padding(.top, 4)
            .padding(.bottom, 12)
            
            
            HStack {
                Text("View More")
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.7))
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundStyle(.white.secondary)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(.thinMaterial)
            .foregroundStyle(
                .black.gradient.shadow(.inner(color: .black.opacity(1.0), radius: 100, x: 40, y: 40))
            )
            //                .overlay{
            //
            //                    RoundedRectangle(cornerRadius: 12)
            //                        .stroke(Color.white.opacity(0.2), lineWidth: 2.0)
            //
            //
            //                }
            .cornerRadius(12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.green.opacity(0.3))
        .background(LinearGradient(colors: [.white.opacity(0.5), .green.opacity(0.3), .mint.opacity(0.3), .black.opacity(0.5)], startPoint: .bottomLeading, endPoint: .topTrailing))
        .cornerRadius(12)
    }
}

#Preview {
    ExplorePassport()
        .padding(20)
}
