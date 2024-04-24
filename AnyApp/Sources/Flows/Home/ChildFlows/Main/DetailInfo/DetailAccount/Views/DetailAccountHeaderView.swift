//
//  DetailAccountHeaderView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DetailAccountHeaderView: BackgroundPrimary {

    private var props: Props?

    override func setup() {
        super.setup()
    }
    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            ImageView(image: props.topImage)
                .height(52)
                .width(52)
                .contentMode(.scaleAspectFill)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            Spacer(.px16)
            Label(text: props.title)
                .fontStyle(.body15sb)
                .foregroundStyle(.textPrimary)
                .textAlignment(.center)
            Spacer(.px6)
            Label(text: props.cardNumber)
                .fontStyle(.caption13)
                .textAlignment(.center)
                .foregroundStyle(.textSecondary)
            Spacer(.px8)
            Label(text: props.moneyCurrent)
                .fontStyle(.largeTitle)
                .textAlignment(.center)
                .foregroundStyle(.textPrimary)
        }
        .layoutMargins(.make(vInsets: 16))
    }
}

// MARK: - Configurable
extension DetailAccountHeaderView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let topImage: UIImage
        let cardNumber: String
        let moneyCurrent: String

        var onTap: StringHandler?

        public static func == (lhs: DetailAccountHeaderView.Props, rhs: DetailAccountHeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(topImage)
            hasher.combine(cardNumber)
            hasher.combine(moneyCurrent)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
