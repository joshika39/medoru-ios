import SwiftUI

struct BrandMark: View {
    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: "leaf.fill")
                .font(.caption)
                .foregroundStyle(MedoruTheme.accent)
            Text("medoru")
                .font(.system(.headline, design: .rounded, weight: .bold))
                .foregroundStyle(MedoruTheme.primaryText)
        }
        .accessibilityElement(children: .combine)
    }
}

struct SymbolBadge: View {
    let symbol: String
    let tint: Color
    var size: CGFloat = 44

    var body: some View {
        Image(systemName: symbol)
            .font(.system(size: size * 0.40, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: size, height: size)
            .background(tint.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: size * 0.28, style: .continuous))
            .accessibilityHidden(true)
    }
}

struct ProfileAvatar: View {
    let initials: String
    var size: CGFloat = 30

    var body: some View {
        Text(initials)
            .font(.system(size: size * 0.36, weight: .bold, design: .rounded))
            .foregroundStyle(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(width: size, height: size)
            .background(MedoruTheme.accent)
            .clipShape(Circle())
            .accessibilityHidden(true)
    }
}

struct NotificationBellButtonLabel: View {
    let unreadCount: Int

    var body: some View {
        Image(systemName: unreadCount > 0 ? "bell.badge" : "bell")
            .symbolRenderingMode(.hierarchical)
            .overlay(alignment: .topTrailing) {
                if unreadCount > 0 {
                    Text(unreadCount, format: .number)
                        .font(.system(size: 9, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .monospacedDigit()
                        .frame(minWidth: 15, minHeight: 15)
                        .padding(.horizontal, unreadCount > 9 ? 3 : 0)
                        .background(.red)
                        .clipShape(Capsule())
                        .offset(x: 8, y: -8)
                        .accessibilityHidden(true)
                }
            }
    }
}

struct NotificationCenterView: View {
    let notifications: [HomeNotification]

    var body: some View {
        ZStack {
            MedoruTheme.background
                .ignoresSafeArea()

            if notifications.isEmpty {
                VStack(spacing: 12) {
                    SymbolBadge(symbol: "bell.slash.fill", tint: MedoruTheme.accent, size: 54)
                    Text("notifications.empty.title")
                        .font(.headline)
                        .foregroundStyle(MedoruTheme.primaryText)
                    Text("notifications.empty.body")
                        .font(.subheadline)
                        .foregroundStyle(MedoruTheme.secondaryText)
                        .multilineTextAlignment(.center)
                }
                .padding(24)
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(notifications) { notification in
                            NotificationRow(notification: notification)
                        }
                    }
                    .padding(18)
                }
                .scrollIndicators(.hidden)
            }
        }
        .navigationTitle(Text("notifications.title"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationRow: View {
    let notification: HomeNotification

    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            SymbolBadge(symbol: notification.symbol, tint: MedoruTheme.accent)

            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text(LocalizedStringKey(notification.titleKey))
                        .font(.headline)
                        .foregroundStyle(MedoruTheme.primaryText)
                        .fixedSize(horizontal: false, vertical: true)

                    if notification.isUnread {
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .accessibilityLabel(Text("notifications.unread"))
                    }
                }

                Text(LocalizedStringKey(notification.bodyKey))
                    .font(.subheadline)
                    .foregroundStyle(MedoruTheme.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)

                Text(LocalizedStringKey(notification.timeKey))
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(MedoruTheme.secondaryText)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .medoruCard()
        .accessibilityElement(children: .combine)
    }
}

struct MetricCard: View {
    let titleKey: LocalizedStringKey
    let value: Int
    let symbol: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SymbolBadge(symbol: symbol, tint: MedoruTheme.accent)

            VStack(alignment: .leading, spacing: 3) {
                Text(titleKey)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(MedoruTheme.secondaryText)
                    .lineLimit(2)
                Text(value, format: .number)
                    .font(.title2.bold().monospacedDigit())
                    .foregroundStyle(MedoruTheme.primaryText)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 126, alignment: .leading)
        .padding(16)
        .medoruCard()
        .accessibilityElement(children: .combine)
    }
}

struct LearningCard: View {
    let titleKey: LocalizedStringKey
    let bodyKey: LocalizedStringKey
    let actionKey: LocalizedStringKey
    let symbol: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 14) {
                SymbolBadge(symbol: symbol, tint: MedoruTheme.accent)

                VStack(alignment: .leading, spacing: 5) {
                    Text(titleKey)
                        .font(.headline)
                        .foregroundStyle(MedoruTheme.primaryText)
                    Text(bodyKey)
                        .font(.subheadline)
                        .foregroundStyle(MedoruTheme.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Button(action: action) {
                Text(actionKey)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(18)
        .medoruCard()
    }
}

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}
