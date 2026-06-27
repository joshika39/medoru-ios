import SwiftUI

enum MedoruTheme {
    static let background = Color(uiColor: .systemGroupedBackground)
    static let surface = Color(uiColor: .secondarySystemGroupedBackground)
    static let border = Color(uiColor: .separator)
    static let accent = Color.accentColor
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    static let cornerRadius: CGFloat = 16
}

struct MedoruCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(MedoruTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: MedoruTheme.cornerRadius, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: MedoruTheme.cornerRadius, style: .continuous)
                    .stroke(MedoruTheme.border.opacity(0.35), lineWidth: 0.5)
            }
    }
}

extension View {
    func medoruCard() -> some View {
        modifier(MedoruCard())
    }
}
