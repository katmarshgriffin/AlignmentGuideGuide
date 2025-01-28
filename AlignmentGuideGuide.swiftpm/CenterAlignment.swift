import SwiftUI

struct CenterAlignment: View {
    var body: some View {
        Text("🦄")
            .font(.system(size: 150))
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottom) {
                Text("Lorem ipsum dolor sit amet")
                    .alignmentGuide(.bottom) { dim in
                        // dim[.top] is the same as 0
                        dim[.top]
                    }
                    // offset could be used here, but alignment guide
                    // provides more exact alignment (avoids magic numbers) and better accomodate dynamic type
//                    .offset(y: 100)
            }
    }
}

#Preview {
    CenterAlignment()
}
