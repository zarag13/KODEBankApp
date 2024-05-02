import UIKit
import UI
import AppIndependent

final class TemplateHeaderView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textTertiary, fontStyle: .body15sb)

    private var props: Props?

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        BackgroundView(hPadding: 16) {
            VStack {
                Spacer(.px16)
                titleLabel
                    .fontStyle(.body15sb)
                    .foregroundStyle(.textTertiary)
                Spacer(.px16)
            }
        }
        .backgroundStyle(.backgroundSecondary)
    }
}

// MARK: - Configurable

extension TemplateHeaderView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let title: String

        public static func == (lhs: TemplateHeaderView.Props, rhs: TemplateHeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        titleLabel.text(model.title)
        self.layoutIfNeeded()
    }
}
