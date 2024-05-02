//
//  SettingsAccountView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UIKit
import UI
import AppIndependent

final class SettingsAccountView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundPrimary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            ImageView(image: props.leftImage)
                .foregroundStyle(.textTertiary)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            Label(text: props.title)
                .fontStyle(.body15r)
                .foregroundStyle(.textSecondary)
                .huggingPriority(.defaultLow, axis: .horizontal)
            configureRightImage(state: props.rightImage)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 16))
        .onTap { [weak self] in
            UIView.animate(
                withDuration: 0.15
            ) {
                self?.alpha = 0.55
            } completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self?.alpha = 1
                }
            }
            SnackCenter.shared.showSnack(withProps: .init(message: Main.featureInDevelopment, style: .basic))
            self?.props?.onTap?(props.id)
        }
    }

    private func configureRightImage(state: Bool) -> ImageView {
        let image = ImageView(image: Asset.Icon24px.chevronDown.image)
        image.huggingPriority(.defaultHigh, axis: .horizontal)
        image.foregroundStyle(.textTertiary)
        if state {
            image.isHidden = false
        } else {
            image.isHidden = true
        }
        return image
    }
}

// MARK: - Configurable
extension SettingsAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let leftImage: UIImage
        let rightImage: Bool
        var onTap: StringHandler?

        public static func == (lhs: SettingsAccountView.Props, rhs: SettingsAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(rightImage)
            hasher.combine(leftImage)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
