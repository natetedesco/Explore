//
//  SheetComponents.swift
//  Explore
//  Created by Developer on 5/15/24.
//

import SwiftUI


func lightHaptic() {
    let impactLit = UIImpactFeedbackGenerator(style: .light)
    impactLit.impactOccurred()
}

extension View {
    func sheetMaterial() -> some View {
        self
            .presentationCornerRadius(32)
            .accentColor(.green.opacity(0.8))
            .presentationBackgroundInteraction(.enabled(upThrough: .fraction(4/10)))
            .interactiveDismissDisabled()
            .presentationDragIndicator(.hidden)
            .ignoresSafeArea()
    }
}

// Dark Background
struct DarkBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            content
        }
    }
}
extension View {
    func darkBackground() -> some View {
        self.modifier(DarkBackground())
    }
}
// Dark Background
struct Background: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.black.opacity(0.1)
                .ignoresSafeArea()
            
            content
        }
    }
}
extension View {
    func background() -> some View {
        self.modifier(Background())
    }
}
