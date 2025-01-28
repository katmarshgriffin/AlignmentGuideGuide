import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            StackBasics()
                .tabItem {
                    Label("Basic", systemImage: "1.circle")
                }

            CenterAlignment()
                .tabItem {
                    Label("Center", systemImage: "2.circle")
                }

            BadgeAlignment()
                .tabItem {
                    Label("Badges", systemImage: "3.circle")
                }

            CustomLabelAlignment()
                .tabItem {
                    Label("CustomLabel", systemImage: "4.circle")
                }

            CustomBackgroundAlignment()
                .tabItem {
                    Label("CustomBackground", systemImage: "5.circle")
                }

            AnimationAlignment()
                .tabItem {
                    Label("Animation", systemImage: "6.circle")
                }
        }
    }
}

#Preview {
    ContentView()
}
