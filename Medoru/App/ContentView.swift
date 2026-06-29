import SwiftUI

struct ContentView: View {
    @State private var path: [HomeDestination] = []
    private let dashboard = HomeDashboard.preview

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(dashboard: dashboard) { action in
                if let destination = HomeDestination(action: action) {
                    path.append(destination)
                }
            }
            .navigationDestination(for: HomeDestination.self) { destination in
                destinationView(for: destination)
            }
        }
        .tint(MedoruTheme.accent)
    }

    @ViewBuilder
    private func destinationView(for destination: HomeDestination) -> some View {
        switch destination {
        case .notifications:
            NotificationCenterView(notifications: dashboard.notifications)
        default:
            HomeDestinationView(destination: destination, dashboard: dashboard)
        }
    }
}

#Preview {
    ContentView()
}
