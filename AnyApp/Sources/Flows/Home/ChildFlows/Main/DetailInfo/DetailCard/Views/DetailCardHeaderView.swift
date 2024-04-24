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
    }
    private func body(with props: Props) -> UIView {
        ZStack(positioningMode: .fill) {
            VStack {
                ImageView(image: props.styleCard)
                .clipsToBounds(true)
                .contentMode(.scaleAspectFit)
                .cornerRadius(20)
            }
            .layoutMargins(.init(top: 16, left: 20, bottom: 0, right: 20))
                .shadowColor(.black)
                .shadowOffset(.init(width: 10, height: 10))
                .shadowRadius(46)
                .shadowOpacity(0.4)
            VStack(spacing: 24) {
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
                HStack {
                    Label(text: props.sumMoney)
                        .fontStyle(.subtitle17sb)
                        .foregroundStyle(.textPrimary)
                }
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
            }
            .layoutMargins(.make(vInsets: 32, hInsets: 48))
        }
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
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
