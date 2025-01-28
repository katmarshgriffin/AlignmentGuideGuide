import SwiftUI

struct BadgeAlignment: View {
    @State private var horizontalOffset: CGFloat = 0
    @State private var verticalOffset: CGFloat = 0

    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 60))
                        .border(.gray.opacity(0.3))
                        .overlay(alignment: .topTrailing) {
                            Circle()
                                .fill(.green)
                                .frame(width: 20, height: 20)
                                .alignmentGuide(.trailing) { [horizontalOffset] dim in
                                    horizontalOffset
                                }
                                .alignmentGuide(.top) { [verticalOffset] _ in
                                    verticalOffset
                                }
                        }
                    Text("Profile")
                }
                
                VStack {
                    Image(systemName: "message.fill")
                        .font(.system(size: 60))
                        .border(.gray.opacity(0.3))
                        .overlay(alignment: .topTrailing) {
                            Text("12")
                                .font(.caption2.bold())
                                .padding(5)
                                .background(.red)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                                .alignmentGuide(.trailing) { [horizontalOffset] _ in horizontalOffset }
                                .alignmentGuide(.top) { [verticalOffset] _ in verticalOffset }
                        }
                    Text("Messages")
                }
            }
            .padding()
            
            VStack(spacing: 10) {
                Text("Alignment Adjustments")
                    .font(.headline)
                
                HStack {
                    Text("Horizontal")
                    Slider(value: $horizontalOffset, in: -15...15)
                    Text("\(Int(horizontalOffset))")
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Vertical")
                    Slider(value: $verticalOffset, in: -15...15)
                    Text("\(Int(verticalOffset))")
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            VStack(spacing: 20) {
                Text("Center Alignment")
                    .font(.headline)
                
                Image(systemName: "message.fill")
                    .font(.system(size: 60))
                    .border(.gray.opacity(0.3))
                    .overlay(alignment: .topTrailing) {
                        Text("12")
                            .font(.caption2.bold())
                            .padding(5)
                            .background(.purple)
                            .foregroundStyle(.white)
                            .clipShape(Circle())
                            .alignmentGuide(.trailing) { dim in
                                dim.width / 2
                                // OR dim[HorizontalAlignment.center]
                            }
                            .alignmentGuide(.top) { dim in
                                dim.height / 2
                                // OR dim[VerticalAlignment.center]
                            }
                    }
            }
            
            Spacer()
        }
    }
}

#Preview {
    BadgeAlignment()
}
