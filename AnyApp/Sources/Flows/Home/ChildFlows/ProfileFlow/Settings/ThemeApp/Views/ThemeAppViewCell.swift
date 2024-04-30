//
//  ThemeAppViewCell.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ThemeAppViewCell: BackgroundPrimary {
    // MARK: - Private Properties
    private var props: Props?
    private let separator = BackgroundView()
    private var imageView = ImageView(foregroundStyle: .textSecondary)

    // MARK: - Public Properties
    public var onEvent: ((ThemeRaw) -> Void)?

    // MARK: - Private Methods
    private func body(with props: Model) -> UIView {
        VStack {
            HStack {
                Label(text: props.title)
                    .fontStyle(.body15r)
                    .foregroundStyle(.contentAccentTertiary)
                    .huggingPriority(.defaultLow, axis: .horizontal)
                imageView
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            .layoutMargins(.make(vInsets: 16))
            separator
                .backgroundStyle(.contentSecondary)
            separator.height(1)
        }
        .onTap { [weak self] in
            self?.onEvent?(props.event)
            props.onTap?(props.event)
        }
    }

    // MARK: - Public Methods
    @discardableResult
    public func separatorIsHidden(_ isHidden: Bool) -> Self {
        separator.isHidden = isHidden
        return self
    }

    public func isSelected(_ theme: ThemeRaw) {
        if props?.event == theme {
            imageView.image(Asset.Icon24px.radioOn.image)
        } else {
            imageView.image(Asset.Icon24px.radioOff.image)
        }
    }
}

// MARK: - Configurable
extension ThemeAppViewCell: ConfigurableView {

    public typealias EventHandler = ((ThemeRaw) -> Void)
    public typealias Model = Props

    public struct Props {
        public let title: String
        public let event: ThemeRaw
        public var onTap: EventHandler?

        public init(
            title: String,
            event: ThemeRaw,
            onTap: EventHandler? = nil) {
                self.title = title
                self.event = event
                self.onTap = onTap
            }
    }

    public func configure(with model: Model) {
        subviews.forEach { $0.removeFromSuperview() }
        self.props = model
        body(with: model).embed(in: self)
    }
}
