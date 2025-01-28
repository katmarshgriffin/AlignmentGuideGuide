import SwiftUI

struct RectangleConfig {
    let color: Color
    let width: CGFloat
    let height: CGFloat
}

struct StackBasics: View {
    @State private var horizontalAlignment: HorizontalAlignment = .center
    @State private var verticalAlignment: VerticalAlignment = .center
    @State private var customOffset: CGFloat = 0
    @State private var selectedHorizontalIndex: Int = 0
    @State private var selectedVerticalIndex: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            controlsSection
            demonstrationSection
        }
    }

    private var controlsSection: some View {
        VStack {
            Slider(value: $customOffset, in: -100...100)
                .padding(.horizontal)

            Text("Selected Rectangle Alignment Offset: \(Int(customOffset))")

            Text("Note: The rectangle with a black border is the one with the alignment guide offset applied. Tap another rectangle to switch the alignment guide offset.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }

    private var demonstrationSection: some View {
        ScrollView {
            StackDemo(
                title: "VStack",
                content: VStackContent(
                    alignment: horizontalAlignment,
                    offset: customOffset,
                    selectedIndex: selectedHorizontalIndex,
                    onTap: { self.selectedHorizontalIndex = $0 }
                ),
                alignment: .init(horizontal: horizontalAlignment, vertical: .center)
            )

            AlignmentControls(
                title: "Horizontal Alignment:",
                options: [
                    ("Leading", .leading, horizontalAlignment == .leading),
                    ("Center", .center, horizontalAlignment == .center),
                    ("Trailing", .trailing, horizontalAlignment == .trailing)
                ],
                action: { self.horizontalAlignment = $0; customOffset = 0 }
            )

            StackDemo(
                title: "HStack",
                content: HStackContent(
                    alignment: verticalAlignment,
                    offset: customOffset,
                    selectedIndex: selectedVerticalIndex,
                    onTap: { self.selectedVerticalIndex = $0 }
                ),
                alignment: .init(horizontal: .center, vertical: verticalAlignment)
            )

            AlignmentControls(
                title: "Vertical Alignment:",
                options: [
                    ("Top", .top, verticalAlignment == .top),
                    ("Center", .center, verticalAlignment == .center),
                    ("Bottom", .bottom, verticalAlignment == .bottom)
                ],
                action: { self.verticalAlignment = $0; customOffset = 0 }
            )
        }
    }
}

struct StackDemo<Content: View>: View {
    let title: String
    let content: Content
    let alignment: Alignment

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .padding()

            content
                .border(.gray)
        }
    }
}

struct VStackContent: View {
    let alignment: HorizontalAlignment
    let offset: CGFloat
    let selectedIndex: Int
    let onTap: (Int) -> Void

    private let configs: [RectangleConfig] = [
        RectangleConfig(color: .pink, width: 100, height: 30),
        RectangleConfig(color: .purple, width: 80, height: 30),
        RectangleConfig(color: .green, width: 60, height: 30)
    ]

    var body: some View {
        VStack(alignment: alignment, spacing: 3) {
            ForEach(0..<3) { index in
                ColoredRectangle(
                    config: configs[index],
                    isSelected: selectedIndex == index,
                    onTap: { onTap(index) }
                )
                .alignmentGuide(alignment) { d in
                    d[alignment] + (selectedIndex == index ? offset : 0)
                }
            }
        }
    }
}

struct HStackContent: View {
    let alignment: VerticalAlignment
    let offset: CGFloat
    let selectedIndex: Int
    let onTap: (Int) -> Void

    private let configs: [RectangleConfig] = [
        RectangleConfig(color: .pink, width: 30, height: 80),
        RectangleConfig(color: .purple, width: 30, height: 100),
        RectangleConfig(color: .green, width: 30, height: 60)
    ]

    var body: some View {
        HStack(alignment: alignment, spacing: 3) {
            ForEach(0..<3) { index in
                ColoredRectangle(
                    config: configs[index],
                    isSelected: selectedIndex == index,
                    onTap: { onTap(index) }
                )
                .alignmentGuide(alignment) { d in
                    d[alignment] + (selectedIndex == index ? offset : 0)
                }
            }
        }
    }
}

struct ColoredRectangle: View {
    let config: RectangleConfig
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Rectangle()
            .fill(config.color)
            .frame(width: config.width, height: config.height)
            .overlay {
                if isSelected {
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                }
            }
            .onTapGesture(perform: onTap)
    }
}

struct AlignmentControls<T>: View {
    let title: String
    let options: [(String, T, Bool)]
    let action: (T) -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            HStack {
                ForEach(options, id: \.0) { option in
                    BorderedButton(
                        title: option.0,
                        isSelected: option.2
                    ) {
                        action(option.1)
                    }
                }
            }
        }
        .padding()
    }
}

struct BorderedButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(.bordered)
            .tint(isSelected ? .blue : .gray)
    }
}

#Preview {
    StackBasics()
}
