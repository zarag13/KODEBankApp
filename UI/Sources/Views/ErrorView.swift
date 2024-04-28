import UIKit
import AppIndependent

public final class ErrorView: BackgroundPrimary {

    // MARK: - Private Properties

    private let titleLabel = Label(foregroundStyle: .textPrimary, fontStyle: .subtitle17sb)
        .textAlignment(.center)
    private let messageLabel = Label(foregroundStyle: .textPrimary, fontStyle: .body15r)
        .textAlignment(.center)
        .multiline()
    private let imageView = ImageView()
        .contentMode(.scaleAspectFit)
    private var retryButton = ButtonPrimary()

    private var props: Props?

    // MARK: - Private methods

    private func body(with props: Props) -> UIView {
        VStack {
            navigatiomBar()
            FlexibleGroupedSpacer()
            imageView
                .image(props.image)
            Spacer(.px32)
            titleLabel
                .text(props.title)
            Spacer(.px16)
            messageLabel
                .text(props.message)
            FlexibleGroupedSpacer()
            retryButton
                .title(props.buttonTitle)
                .onTap { [weak self] in
                    self?.retryButton.startLoading()
                    self?.props?.onTap?()
                }
        }
        .linkGroupedSpacers()
        .layoutMargins(.init(top: 0, left: 16, bottom: 32, right: 16))
    }

    private func navigatiomBar() -> UIView {
        HStack {
            ImageView(image: UIImage(named: "Icon24px/close"), foregroundStyle: .textPrimary)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .onTap { [weak self] in
                    self?.removeFromSuperview()
                }
            FlexibleSpacer()
        }
        .layoutMargins(.make(vInsets: 10))
    }

    public func stopAnimation() {
        self.retryButton.stopLoading()
    }
}

// MARK: - Configurable

extension ErrorView: ConfigurableView {

    public typealias Model = Props

    public struct Props {
        public let title: String
        public let message: String
        public let image: UIImage

        public var buttonTitle: String
        public var onTap: VoidHandler?

        public init(title: String, message: String, image: UIImage, buttonTitle: String, onTap: VoidHandler? = nil) {
            self.title = title
            self.message = message
            self.image = image
            self.buttonTitle = buttonTitle
            self.onTap = onTap
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
