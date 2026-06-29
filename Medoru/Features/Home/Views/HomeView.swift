import SwiftUI

struct HomeView: View {
    let dashboard: HomeDashboard
    var onAction: (HomeAction) -> Void = { _ in }

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ZStack {
            MedoruTheme.background
                .ignoresSafeArea()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 22) {
                    welcomeHeader
                    streakCard
                    metricsGrid
                    progressCard
                    classroomCard
                    learningSection
                    boardSection
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
                .padding(.bottom, 36)
            }
            .scrollIndicators(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                BrandMark()
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    onAction(.notifications)
                } label: {
                    Image(systemName: "bell")
                }
                .accessibilityLabel(Text("nav.notifications"))

                Button {
                    onAction(.profile)
                } label: {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.title3)
                }
                .accessibilityLabel(Text("nav.profile"))
            }
        }
    }

    private var welcomeHeader: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(welcomeText)
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(MedoruTheme.primaryText)
                .fixedSize(horizontal: false, vertical: true)

            Text("home.subtitle")
                .font(.subheadline)
                .foregroundStyle(MedoruTheme.secondaryText)
        }
    }

    private var welcomeText: String {
        String.localizedStringWithFormat(
            String(localized: "home.welcome.format"),
            dashboard.profile.username
        )
    }

    private var streakCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 14) {
                SymbolBadge(symbol: "flame.fill", tint: MedoruTheme.accent, size: 48)

                VStack(alignment: .leading, spacing: 5) {
                    Text("streak.title")
                        .font(.headline)
                        .foregroundStyle(MedoruTheme.primaryText)
                    Text("streak.body")
                        .font(.subheadline)
                        .foregroundStyle(MedoruTheme.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Button {
                onAction(.dailyChallenges)
            } label: {
                Label("streak.action", systemImage: "play.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(18)
        .medoruCard()
    }

    private var metricsGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            MetricCard(titleKey: "stats.level", value: dashboard.level, symbol: "sparkles")
            MetricCard(titleKey: "stats.currentStreak", value: dashboard.currentStreak, symbol: "flame.fill")
            MetricCard(titleKey: "stats.longestStreak", value: dashboard.longestStreak, symbol: "trophy.fill")
            MetricCard(titleKey: "stats.kanji", value: dashboard.kanjiLearned, symbol: "book.closed.fill")
            MetricCard(titleKey: "stats.words", value: dashboard.wordsLearned, symbol: "doc.text.fill")
            MetricCard(titleKey: "stats.grammar", value: dashboard.grammarLearned, symbol: "character.book.closed.fill")
        }
    }

    private var progressCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("progress.title")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(MedoruTheme.primaryText)
                Spacer()
                Text(progressValueText)
                    .font(.subheadline.monospacedDigit())
                    .foregroundStyle(MedoruTheme.secondaryText)
            }

            ProgressView(value: dashboard.levelProgress)
                .tint(MedoruTheme.accent)
                .scaleEffect(x: 1, y: 1.8, anchor: .center)
        }
        .padding(18)
        .medoruCard()
    }

    private var progressValueText: String {
        String.localizedStringWithFormat(
            String(localized: "progress.value.format"),
            dashboard.currentExperience,
            dashboard.experienceForNextLevel
        )
    }

    private var classroomCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top, spacing: 14) {
                SymbolBadge(symbol: "person.3.fill", tint: MedoruTheme.accent, size: 48)
                VStack(alignment: .leading, spacing: 5) {
                    Text("classrooms.title")
                        .font(.headline)
                        .foregroundStyle(MedoruTheme.primaryText)
                    Text("classrooms.body")
                        .font(.subheadline)
                        .foregroundStyle(MedoruTheme.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Button {
                onAction(.classrooms)
            } label: {
                Label("classrooms.action", systemImage: "arrow.right")
                    .labelStyle(TrailingIconLabelStyle())
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding(18)
        .medoruCard()
    }

    private var learningSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("learning.section.title")
                .font(.title3.bold())
                .foregroundStyle(MedoruTheme.primaryText)

            LearningCard(
                titleKey: "learning.continue.title",
                bodyKey: "learning.continue.body",
                actionKey: "learning.continue.action",
                symbol: "graduationcap.fill"
            ) {
                onAction(.lessons)
            }

            LearningCard(
                titleKey: "learning.kanji.title",
                bodyKey: "learning.kanji.body",
                actionKey: "learning.kanji.action",
                symbol: "character.book.closed.fill"
            ) {
                onAction(.kanji)
            }

            LearningCard(
                titleKey: "learning.words.title",
                bodyKey: "learning.words.body",
                actionKey: "learning.words.action",
                symbol: "doc.text.fill"
            ) {
                onAction(.words)
            }
        }
    }

    private var boardSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 8) {
                Text("board.title")
                    .font(.title3.bold())
                    .foregroundStyle(MedoruTheme.primaryText)
                Text(boardPostCountText)
                    .font(.subheadline)
                    .foregroundStyle(MedoruTheme.secondaryText)
            }

            VStack(spacing: 12) {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                    .font(.system(size: 30))
                    .foregroundStyle(MedoruTheme.accent)
                Text("board.empty.title")
                    .font(.headline)
                    .foregroundStyle(MedoruTheme.primaryText)
                Text("board.empty.body")
                    .font(.subheadline)
                    .foregroundStyle(MedoruTheme.secondaryText)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 28)
            .padding(.horizontal, 18)
            .medoruCard()
        }
    }

    private var boardPostCountText: String {
        String.localizedStringWithFormat(
            String(localized: "board.postCount.format"),
            dashboard.boardPostCount
        )
    }
}

enum HomeAction {
    case notifications
    case profile
    case dailyChallenges
    case classrooms
    case lessons
    case kanji
    case words
}

#Preview("English Light") {
    NavigationStack {
        HomeView(dashboard: .preview)
    }
}

#Preview("Japanese Dark") {
    NavigationStack {
        HomeView(dashboard: .preview)
    }
    .environment(\.locale, Locale(identifier: "ja"))
    .preferredColorScheme(.dark)
}
