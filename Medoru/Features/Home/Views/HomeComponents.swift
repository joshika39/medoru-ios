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
