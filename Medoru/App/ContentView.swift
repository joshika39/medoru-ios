import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            HomeView(dashboard: .preview)
        }
        .tint(MedoruTheme.accent)
    }
}

#Preview {
    ContentView()
}
