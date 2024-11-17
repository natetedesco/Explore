//
//  Description.swift
//  Explore
//
//  Created by Developer on 11/16/24.
//

import SwiftUI

struct Description: View {
    @State var model: Model
    @State var expanded: Bool = false
    @State var truncated: Bool = false
    @State var shrinkText: String
    @Binding var location: Location
    
    let lineLimit = 5
    let font: UIFont
    
    init(model: Model, location: Binding<Location>, font: UIFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)) {
        self._location = location
        self.model = model
        self._shrinkText = State(wrappedValue: model.selectedLocation?.description ?? "")
        self.font = font
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Group {
                Text(expanded ? (model.selectedLocation?.description ?? "") : shrinkText) +
                Text(expanded ? "" : truncated ? "..." : "") +
                Text(moreLessText)
                    .foregroundStyle(.green)
            }
            .animation(.easeInOut(duration: 1.0), value: false)
            .lineLimit(expanded ? nil : lineLimit)
            .background(
                // Render the limited text and measure its size
                Text(model.selectedLocation?.description ?? "")
                    .lineLimit(lineLimit)
                    .background(GeometryReader { visibleTextGeometry in
                        Color.clear.onAppear() {
                            let size = CGSize(width: visibleTextGeometry.size.width, height: .greatestFiniteMagnitude)
                            let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
                            
                            // Binary search until mid == low && mid == high
                            var low = 0
                            var heigh = shrinkText.count
                            var mid = heigh // start from top so that if text contains we do not need to loop
                            
                            while (heigh - low) > 1 {
                                let attributedText = NSAttributedString(string: shrinkText + moreLessText, attributes: attributes)
                                let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
                                if boundingRect.size.height > visibleTextGeometry.size.height {
                                    truncated = true
                                    heigh = mid
                                    mid = (heigh + low) / 2
                                } else {
                                    if mid == model.selectedLocation?.description?.count ?? 0 {
                                        break
                                    } else {
                                        low = mid
                                        mid = (low + heigh) / 2
                                    }
                                }
                                shrinkText = String((model.selectedLocation?.description ?? "").prefix(mid))
                            }
                            
                            if truncated {
                                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  // -2 extra as highlighted text is bold
                            }
                        }
                    })
                    .hidden() // Hide the background
            )
            .font(Font(font)) // set default font
            
            if truncated {
                Button(action: {
                    expanded.toggle()
                }, label: {
                    HStack { // taking tap on only last line, as it is not possible to get 'see more' location
                        Spacer()
                        Text("")
                    }.opacity(0)
                })
            }
        }
        .onChange(of: model.selectedLocation?.description) { newDescription in
            updateShrinkText(with: newDescription)
        }
    }
    
    private var moreLessText: String {
        if !truncated {
            return ""
        } else {
            return self.expanded ? "" : "  more"
        }
    }
    
    private func updateShrinkText(with newDescription: String?) {
        guard let description = newDescription else {
            shrinkText = ""
            return
        }
        let size = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font]
        
        // Binary search until mid == low && mid == high
        var low = 0
        var heigh = description.count
        var mid = heigh
        
        while (heigh - low) > 1 {
            let attributedText = NSAttributedString(string: String(description.prefix(mid)) + moreLessText, attributes: attributes)
            let boundingRect = attributedText.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            if boundingRect.size.height > CGFloat(lineLimit) * font.lineHeight {
                truncated = true
                heigh = mid
                mid = (heigh + low) / 2
            } else {
                low = mid
                mid = (low + heigh) / 2
            }
        }
        
        shrinkText = String(description.prefix(mid))
        if truncated {
            if shrinkText.count >= 2 {
                shrinkText = String(shrinkText.prefix(shrinkText.count - 2))  // -2 extra as highlighted text is bold
            } else {
                shrinkText = ""  // or handle this case as appropriate for your use case
            }
        }
    }
}

#Preview {
    //    Description()
}
