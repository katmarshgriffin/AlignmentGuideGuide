import SwiftUI

// Custom Alignments allow us to align views that reside on different branches of the view hierarchy
extension VerticalAlignment {
    private struct LabelAlignment: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.firstTextBaseline]
        }
    }
    
    static let labelAlignmentGuide = VerticalAlignment(LabelAlignment.self)
}

struct OrderInfoCard: View {
    let image: Image
    let title: String
    let subtitle: String

    // Without default firstTextBaseline Vertical Alignment, this looks ok with text on a single line
    // Our custom labelAlignmentGuide allows for better alignment with dynamic type
    var body: some View {
        HStack(
            alignment: .labelAlignmentGuide,
            spacing: 12
        ) {
            image
                .alignmentGuide(.labelAlignmentGuide) { dimension in
                    dimension[VerticalAlignment.center]
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .alignmentGuide(.labelAlignmentGuide) { dimension in
                        dimension[VerticalAlignment.center]
                    }

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
    }
}

struct CustomLabelAlignment: View {
    let examples = [
        (Image(systemName: "car.fill"), "Ride Request", "Order #12345"),
        (Image(systemName: "bicycle"), "Bike Delivery", "Express Delivery"),
        (Image(systemName: "box.truck.fill"), "Moving Service", "Large Items"),
        (Image(systemName: "figure.walk"), "Food Delivery", "Estimated: 30min")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(examples, id: \.1) { example in
                    OrderInfoCard(
                        image: example.0,
                        title: example.1,
                        subtitle: example.2
                    )
                }
            }
            .padding()
        }
    }
}

#Preview {
    CustomLabelAlignment()
}
