//
//  FavoritesAccountView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UIKit
import UI
import AppIndependent

final class FavoritesAccountView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundSecondary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            configureLeftImage(image: props.leftImage)
            Label(text: props.title)
                .fontStyle(.body15r)
                .foregroundStyle(.textPrimary)
                .huggingPriority(.defaultLow, axis: .horizontal)
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 16))
        .onTap { [weak self] in
            UIView.animate(
                withDuration: 0.15) {
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
    private func configureLeftImage(image: UIImage) -> UIView {
        VStack {
            VStack {
                ImageView(image: image)
                    .foregroundStyle(.contentAccentPrimary)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            .layoutMargins(.all(8))
        }
        .cornerRadius(20)
        .backgroundColor(ForegroundStyle.contentSecondary.color)
    }
}

// MARK: - Configurable
extension FavoritesAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let leftImage: UIImage
        var onTap: StringHandler?

        public static func == (lhs: FavoritesAccountView.Props, rhs: FavoritesAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(leftImage)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
