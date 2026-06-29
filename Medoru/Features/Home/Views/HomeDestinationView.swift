import SwiftUI

enum HomeDestination: String, Hashable {
    case notifications
    case profile
    case dailyChallenges
    case classrooms
    case lessons
    case kanji
    case words

    init?(action: HomeAction) {
        switch action {
        case .notifications: self = .notifications
        case .profile: self = .profile
        case .dailyChallenges: self = .dailyChallenges
        case .classrooms: self = .classrooms
        case .lessons: self = .lessons
        case .kanji: self = .kanji
        case .words: self = .words
        default: return nil
        }
    }

    var titleKey: LocalizedStringKey {
        if self == .notifications {
            return "notifications.title"
        }
        return LocalizedStringKey("destination.\(rawValue).title")
    }

    var bodyKey: LocalizedStringKey {
        LocalizedStringKey("destination.\(rawValue).body")
    }

    var symbol: String {
        switch self {
        case .notifications: "bell.fill"
        case .profile: "person.crop.circle.fill"
        case .dailyChallenges: "flame.fill"
        case .classrooms: "person.3.fill"
        case .lessons: "graduationcap.fill"
        case .kanji: "character.book.closed.fill"
        case .words: "doc.text.fill"
        }
    }
}

struct HomeDestinationView: View {
    let destination: HomeDestination
    let dashboard: HomeDashboard

    var body: some View {
        ZStack {
            MedoruTheme.background
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 14) {
                        SymbolBadge(symbol: destination.symbol, tint: MedoruTheme.accent, size: 58)

                        Text(destination.titleKey)
                            .font(.system(.title2, design: .rounded, weight: .bold))
                            .foregroundStyle(MedoruTheme.primaryText)

                        Text(destination.bodyKey)
                            .font(.body)
                            .foregroundStyle(MedoruTheme.secondaryText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .medoruCard()

                    Label("destination.ready", systemImage: "checkmark.circle.fill")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(MedoruTheme.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .medoruCard()

                    if destination == .profile {
                        profileCard
                    }
                }
                .padding(18)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(destination.titleKey)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var profileCard: some View {
        HStack(spacing: 14) {
            ProfileAvatar(initials: dashboard.profile.initials, size: 48)
            VStack(alignment: .leading, spacing: 3) {
                Text(dashboard.profile.fullName)
                    .font(.headline)
                    .foregroundStyle(MedoruTheme.primaryText)
                Text("@\(dashboard.profile.username)")
                    .font(.subheadline)
                    .foregroundStyle(MedoruTheme.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(18)
        .medoruCard()
    }
}
