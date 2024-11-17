//
//  Components.swift
//  Explore
//  Created by Developer on 5/19/24.
//

import SwiftUI


struct TopProfileBar: View {
    @Binding var show: Bool
    
    var body: some View {
        HStack {
            Circle()
                .foregroundStyle(LinearGradient(colors: [.green.opacity(0.7), .teal.opacity(0.7)], startPoint: .topTrailing, endPoint: .bottomLeading))
                .frame(height: 40)
                .overlay {
                    Text("NT")
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .fontDesign(.rounded)
                }
                .padding(.trailing, 4)
            
                Text("Nate Tedesco")
                    .font(.title3)
                    .fontWeight(.semibold)
            
            Spacer()
            
            Button {
                show = false
            } label: {
                Image(systemName: "xmark")
                    .font(.callout)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white.tertiary)
                    .padding(6)
                    .background(Circle().foregroundStyle(.ultraThinMaterial))
            }
        }
    }
}

// Tab Button
struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct TabButton: View {
    var title: String
    @Binding var toggle: Int
    @State var value: Int
    @State private var width: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                toggle = value
            } label: {
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(toggle == value ? .white : .white.opacity(0.4))
                    .fontWeight(.medium)
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(key: WidthPreferenceKey.self, value: geometry.size.width)
                        }
                    )
            }
            
            Rectangle()
                .frame(width: width)
                .foregroundStyle(.green)
                .cornerRadius(4)
                .frame(height: 2)
                .padding(.top, -4)
                .opacity(toggle == value ? 1 : 0)
        }
        .onPreferenceChange(WidthPreferenceKey.self) { value in
            width = value
        }
        .animation(.default, value: toggle)
    }
}

#Preview {
    ZStack {}
        .sheet(isPresented: .constant(true)) {
            ProfileView(model: Model())
                .sheetMaterial()
                .presentationDetents([.medium])
        }
}
