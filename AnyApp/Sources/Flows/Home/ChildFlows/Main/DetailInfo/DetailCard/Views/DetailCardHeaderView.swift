//
//  DetailCardHeaderView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DetailCardHeaderView: BackgroundPrimary {

    private var props: Props?

    override func setup() {
        super.setup()
        self.backgroundStyle(.backgroundSecondary)
    }

    private func body(with props: Props) -> UIView {
        VStack() {
            crateCards(with: props)
            Spacer(.px32)
        }
    }

    private func crateCards(with props: Props) -> UIView {
        let imageView = VStack(alignment: .center, distribution: .fill) {
            Spacer(.px16)
            ImageView(image: props.styleCard)
                .clipsToBounds(true)
                .contentMode(.scaleAspectFit)
                .cornerRadius(8)
        }
            .layoutMargins(.make(hInsets: 20))
            .shadowColor(.black)
            .shadowOffset(.init(width: 10, height: 10))
            .shadowRadius(36)
            .shadowOpacity(0.4)

        let content = VStack {
            Spacer(.px32)
            HStack(spacing: 16) {
                ImageView(image: props.companyCard)
                    .width(32)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                Label(text: props.title)
                    .textAlignment(.left)
                    .fontStyle(.body15r)
                    .foregroundStyle(.textPrimary)
                    .huggingPriority(.defaultLow, axis: .horizontal)
                ImageView(image: props.rightImage)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                    .foregroundStyle(.contentAccentTertiary)
            }
            Spacer(.px24)
            Label(text: props.sumMoney)
                .fontStyle(.subtitle17sb)
                .foregroundStyle(.textPrimary)
            Spacer(.px24)
            HStack {
                Label(text: props.numberCard)
                    .fontStyle(.caption13)
                    .foregroundStyle(.textSecondary)
                    .huggingPriority(.defaultLow, axis: .horizontal)
                Label(text: props.dateCard)
                    .fontStyle(.caption13)
                    .foregroundStyle(.textSecondary)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            Spacer(.px32)
        }
            //.layoutMargins(.make(vInsets: 16, hInsets: 24))
            .layoutMargins(.make(hInsets: 48))
            .backgroundColor(.clear)
        content.embed(in: imageView)
        return imageView
    }
}

// MARK: - Configurable
extension DetailCardHeaderView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let sumMoney: String
        let numberCard: String
        let dateCard: String
        let styleCard: UIImage
        let companyCard: UIImage
        let rightImage: UIImage
        var onTap: StringHandler?

        public static func == (lhs: DetailCardHeaderView.Props, rhs: DetailCardHeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(sumMoney)
            hasher.combine(numberCard)
            hasher.combine(dateCard)
            hasher.combine(companyCard)
            hasher.combine(rightImage)
            hasher.combine(styleCard)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
