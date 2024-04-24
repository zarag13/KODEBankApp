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
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        VStack {
            titleLabel
                .fontStyle(.body15sb)
                .foregroundStyle(.textTertiary)
        }
        .layoutMargins(.make(vInsets: 17, hInsets: 16))
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
    }
}