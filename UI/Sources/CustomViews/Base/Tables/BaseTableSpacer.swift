import Foundation

// swiftlint:disable:next final_class
public class BaseTableSpacer: BaseView, ConfigurableView {

    // MARK: - Typealiases

    public typealias Model = Props

    // MARK: - Types

    public struct Props: Hashable {
        public let id = UUID()
        public let height: CGFloat
        public let style: BackgroundStyle?

        public init(height: CGFloat, style: BackgroundStyle?) {
            self.height = height
            self.style = style
        }
    }

    // MARK: - Public Methods

    public func configure(with model: Model) {
        subviews.forEach { $0.removeFromSuperview() }
        BackgroundView().height(model.height).backgroundStyle(model.style ?? .none).embed(in: self)
    }
}
