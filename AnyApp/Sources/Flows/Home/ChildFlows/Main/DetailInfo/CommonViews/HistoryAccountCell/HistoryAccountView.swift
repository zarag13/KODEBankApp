//
//  HistoryAccountView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UIKit
import UI
import AppIndependent

final class HistoryAccountView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundPrimary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .top, distribution: .fill, spacing: 16) {
            configureImage(image: props.leftImage)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            VStack(spacing: 6) {
                HStack {
                    Label(text: props.title)
                        .fontStyle(.caption13)
                        .foregroundStyle(.textTertiary)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    configureMoneyLabel(text: props.money)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                }
                HStack {
                    Label(text: props.description)
                        .fontStyle(.body15r)
                        .foregroundStyle(.textPrimary)
                        .multiline()
                }
            }
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }

    private func configureMoneyLabel(text: String) -> Label {
        let label = Label(text: text)
        let state = self.validateTextMoneyLabel(text: text)
        switch state {
        case .plus:
            label.foregroundStyle(.indicatorContentDone)
        case .minus:
            label.foregroundStyle(.indicatorContentError)
        case .error:
            label.foregroundStyle(.textTertiary)
            label.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        }
        return label
    }

    enum ValidateManyeLabelState {
        case plus
        case minus
        case error
    }
    private func validateTextMoneyLabel(text: String) -> ValidateManyeLabelState {
        let startIndex = text.startIndex
        let char = text[startIndex]
        if char == "+" {
            return .plus
        } else if char == "-" {
            return .minus
        } else {
            return .error
        }
    }
    
    private func configureImage(image: UIImage) -> UIView {
        
        if image.size.width >= 40 {
            let imageView = ImageView(image: image)
            imageView.huggingPriority(.defaultHigh, axis: .horizontal)
            return imageView
        } else {
            let imageView = VStack {
                VStack {
                    ImageView(image: image)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                        .foregroundStyle(.contentAccentPrimary)
                }
                .layoutMargins(.all(8))
            }
            imageView.backgroundColor = ForegroundStyle.contentSecondary.color
            imageView.cornerRadius(20)
            return imageView
        }
    }
}

// MARK: - Configurable
extension HistoryAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String
        let leftImage: UIImage
        let money: String
        var onTap: StringHandler?

        public static func == (lhs: HistoryAccountView.Props, rhs: HistoryAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(leftImage)
            hasher.combine(money)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
