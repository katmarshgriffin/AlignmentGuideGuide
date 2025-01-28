import SwiftUI

// Custom Alignments allow us to align views that reside on different branches of the view hierarchy
// In this example, it allows us to align with our header background view
extension VerticalAlignment {
    private struct HeaderBottomAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.bottom]
        }
    }

    static let headerBottom = VerticalAlignment(HeaderBottomAlignment.self)
}

struct CustomBackgroundAlignment: View {
    @State private var headerHeight: CGFloat = 300
    @State private var showAlignmentDebug = false

    var body: some View {
        VStack {
            VStack {
                Text("Hi! Welcome to the header content")
                    .font(.largeTitle)

                Text("Featured Item")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(50)
                    .background(.teal)
                    .padding(.horizontal, 50)
                    .alignmentGuide(.headerBottom) { d in
                        d[VerticalAlignment.center]
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: headerHeight)
            .background(alignment: .init(horizontal: .center, vertical: .headerBottom)) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial)
                    .shadow(radius: 10)
            }
            Spacer()

            VStack(spacing: 10) {
                Text("Header Height: \(Int(headerHeight))")
                Slider(value: $headerHeight, in: 200...500)
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(12)
            .padding()
        }
    }
}

#Preview {
    CustomBackgroundAlignment()
}
