//
//  TemplateDepositsView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateDepositsView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            ImageView(image: props.rightImage)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Label(text: props.title, foregroundStyle: .textPrimary, fontStyle: .body15r)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    Label(text: props.percentStake, foregroundStyle: .textTertiary, fontStyle: .caption11)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                }
                HStack(alignment: .center) {
                    Label(text: props.description, foregroundStyle: .contentAccentPrimary, fontStyle: .body15r)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    Label(text: props.date, foregroundStyle: .textTertiary, fontStyle: .caption11)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                }
            }
                .huggingPriority(.defaultLow, axis: .horizontal)
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
}

// MARK: - Configurable
extension TemplateDepositsView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        let id: String
        let title: String
        let description: String
        let rightImage: UIImage
        let percentStake: String
        let date: String
        var onTap: StringHandler?

        public static func == (lhs: TemplateDepositsView.Props, rhs: TemplateDepositsView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(rightImage)
            hasher.combine(percentStake)
            hasher.combine(date)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
