import XCTest
@testable import Medoru

final class HomeDashboardTests: XCTestCase {
    func testLevelProgressUsesExperienceRatio() {
        let dashboard = makeDashboard(currentExperience: 250, experienceForNextLevel: 1_000)

        XCTAssertEqual(dashboard.levelProgress, 0.25)
    }

    func testLevelProgressIsClampedToValidRange() {
        XCTAssertEqual(makeDashboard(currentExperience: -10, experienceForNextLevel: 100).levelProgress, 0)
        XCTAssertEqual(makeDashboard(currentExperience: 120, experienceForNextLevel: 100).levelProgress, 1)
    }

    func testLevelProgressHandlesInvalidTarget() {
        XCTAssertEqual(makeDashboard(currentExperience: 10, experienceForNextLevel: 0).levelProgress, 0)
    }

    func testUnreadNotificationCountOnlyIncludesUnreadItems() {
        let dashboard = makeDashboard(
            notifications: [
                HomeNotification(
                    titleKey: "one",
                    bodyKey: "one.body",
                    timeKey: "one.time",
                    symbol: "bell",
                    isUnread: true
                ),
                HomeNotification(
                    titleKey: "two",
                    bodyKey: "two.body",
                    timeKey: "two.time",
                    symbol: "bell",
                    isUnread: false
                ),
                HomeNotification(
                    titleKey: "three",
                    bodyKey: "three.body",
                    timeKey: "three.time",
                    symbol: "bell",
                    isUnread: true
                )
            ]
        )

        XCTAssertEqual(dashboard.unreadNotificationCount, 2)
    }

    func testProfileInitialsUseFirstTwoNameParts() {
        let profile = UserProfile(fullName: "Test User", username: "test")

        XCTAssertEqual(profile.initials, "TU")
    }

    func testProfileInitialsFallbackToUsername() {
        let profile = UserProfile(fullName: "", username: "test")

        XCTAssertEqual(profile.initials, "T")
    }

    func testPrimaryHomeActionsMapToDestinations() {
        XCTAssertEqual(HomeDestination(action: .notifications), .notifications)
        XCTAssertEqual(HomeDestination(action: .profile), .profile)
        XCTAssertEqual(HomeDestination(action: .dailyChallenges), .dailyChallenges)
        XCTAssertEqual(HomeDestination(action: .classrooms), .classrooms)
        XCTAssertEqual(HomeDestination(action: .lessons), .lessons)
        XCTAssertEqual(HomeDestination(action: .kanji), .kanji)
        XCTAssertEqual(HomeDestination(action: .words), .words)
    }

    func testSecondaryHomeActionsDoNotCreatePrimaryDestinations() {
        XCTAssertNil(HomeDestination(action: .profileSettings))
        XCTAssertNil(HomeDestination(action: .signOut))
    }

    private func makeDashboard(
        currentExperience: Int = 0,
        experienceForNextLevel: Int = 1_000,
        notifications: [HomeNotification] = []
    ) -> HomeDashboard {
        HomeDashboard(
            profile: UserProfile(fullName: "Test User", username: "test"),
            level: 1,
            currentStreak: 0,
            longestStreak: 0,
            kanjiLearned: 0,
            wordsLearned: 0,
            grammarLearned: 0,
            currentExperience: currentExperience,
            experienceForNextLevel: experienceForNextLevel,
            boardPostCount: 0,
            notifications: notifications
        )
    }
}
