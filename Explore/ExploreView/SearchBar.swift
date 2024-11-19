//
//  SearchBar.swift
//  Explore
//  Created by Developer on 5/18/24.
//

import SwiftUI

struct SearchBar: View {
    @State var model: Model
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "mountain.2")
                    .foregroundStyle(.green.opacity(0.8))
                    .font(.title2)
                    .fontWeight(.semibold)
                TextField("Explore", text: $model.search)
                    .fontWeight(.medium)
                    .onSubmit(of: .text) {
                        Task {
                            
                        }
                    }
                    .submitLabel(.search)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(.ultraThinMaterial)
            .cornerRadius(24)
            
            // Profile Button
            Button {
                if model.selectedTag == nil {
                    model.showProfile.toggle()
                } else {
                    model.selectedTag = nil
                    model.search = ""
                }
                lightHaptic()
            } label: {
                Circle()
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(height: 40)
                    .overlay {
                        Image(systemName: model.selectedTag == nil ? "person.fill" : "xmark")
                            .font(model.selectedTag == nil ? .title3 : .body)
                            .fontWeight(.bold)
                            .foregroundStyle(
                                model.selectedTag == nil ?
                                    .green.opacity(0.8) : .white.opacity(0.3)
                            )
                    }
            }
        }
    }
}
