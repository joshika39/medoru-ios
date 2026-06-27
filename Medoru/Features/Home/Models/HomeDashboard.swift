import Foundation

struct UserProfile: Equatable {
    let fullName: String
    let username: String
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

    var levelProgress: Double {
        guard experienceForNextLevel > 0 else { return 0 }
        return min(max(Double(currentExperience) / Double(experienceForNextLevel), 0), 1)
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
        boardPostCount: 0
    )
}
