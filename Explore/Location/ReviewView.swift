//
//  ReviewView.swift
//  Explore
//  Created by Developer on 5/26/24.
//

import SwiftUI

struct ReviewView: View {
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                
                VStack {
                    Text("Leave Review")
                        .font(.callout)
                        .foregroundStyle(.tertiary)
                }
                .frame(maxWidth: .infinity)
                .frame(minHeight: 112)
                .background(.bar)
                .cornerRadius(12)
                .padding(.top, 32)
                
                Spacer()
                
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .cornerRadius(20)
                    .padding(.bottom)
                
            }
            .padding(.horizontal, 24)
            .navigationTitle("Review").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Cancel")
                        .foregroundStyle(.green)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                }
            }
        }
    }
}

import MapKit
#Preview {
    Map()
        .sheet(isPresented: .constant(true)) {
            ReviewView()
                .presentationDetents([.fraction(9999/10000)])
                .presentationCornerRadius(32)
        }
}
