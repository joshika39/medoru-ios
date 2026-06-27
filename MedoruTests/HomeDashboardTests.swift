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

    private func makeDashboard(
        currentExperience: Int,
        experienceForNextLevel: Int
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
            boardPostCount: 0
        )
    }
}
