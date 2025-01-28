import SwiftUI

// Example from: https://benscheirman.com/2024/01/swiftui-alignment-guide.html
struct AnimationAlignment: View {
    @State private var isLinked = true

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.red)
                .frame(width: 50, height: 100)
                .alignmentGuide(HorizontalAlignment.center) { [isLinked] d in
                    d[isLinked ? .center : .trailing]
                }

            Rectangle()
                .fill(.red)
                .frame(width: 50, height: 100)
                .alignmentGuide(HorizontalAlignment.center) { [isLinked] d in
                    d[isLinked ? .center : .leading]
                }
        }
        .onTapGesture {
            withAnimation {
                isLinked.toggle()
            }
        }
    }
}

#Preview {
    AnimationAlignment()
}
