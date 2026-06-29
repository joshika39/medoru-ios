import Foundation

struct UserProfile: Equatable {
    let fullName: String
    let username: String

    var initials: String {
        let initials = fullName
            .split(separator: " ")
            .prefix(2)
            .compactMap { $0.first }

        return initials.isEmpty ? String(username.prefix(1)).uppercased() : String(initials).uppercased()
    }
}

struct HomeNotification: Identifiable, Equatable {
    let id: UUID
    let titleKey: String
    let bodyKey: String
    let timeKey: String
    let symbol: String
    let isUnread: Bool

    init(
        id: UUID = UUID(),
        titleKey: String,
        bodyKey: String,
        timeKey: String,
        symbol: String,
        isUnread: Bool
    ) {
        self.id = id
        self.titleKey = titleKey
        self.bodyKey = bodyKey
        self.timeKey = timeKey
        self.symbol = symbol
        self.isUnread = isUnread
    }
}

struct HomeDashboard: Equatable {
    let profile: UserProfile
    let level: Int
    let currentStreak: Int
    let longestStreak: Int
    let kanjiLearned: Int
    let wordsLearned: Int
    let grammarLearned: Int
    let currentExperience: Int
    let experienceForNextLevel: Int
    let boardPostCount: Int
    let notifications: [HomeNotification]

    var levelProgress: Double {
        guard experienceForNextLevel > 0 else { return 0 }
        return min(max(Double(currentExperience) / Double(experienceForNextLevel), 0), 1)
    }

    var unreadNotificationCount: Int {
        notifications.filter(\.isUnread).count
    }
}

extension HomeDashboard {
    static let preview = HomeDashboard(
        profile: UserProfile(fullName: "Joshua Hegedus", username: "joshika39"),
        level: 0,
        currentStreak: 0,
        longestStreak: 0,
        kanjiLearned: 0,
        wordsLearned: 0,
        grammarLearned: 0,
        currentExperience: 0,
        experienceForNextLevel: 1_000,
        boardPostCount: 0,
        notifications: [
            HomeNotification(
                titleKey: "notifications.lesson.title",
                bodyKey: "notifications.lesson.body",
                timeKey: "notifications.time.today",
                symbol: "graduationcap.fill",
                isUnread: true
            ),
            HomeNotification(
                titleKey: "notifications.streak.title",
                bodyKey: "notifications.streak.body",
                timeKey: "notifications.time.yesterday",
                symbol: "flame.fill",
                isUnread: true
            ),
            HomeNotification(
                titleKey: "notifications.classroom.title",
                bodyKey: "notifications.classroom.body",
                timeKey: "notifications.time.week",
                symbol: "person.3.fill",
                isUnread: false
            )
        ]
    )
}
