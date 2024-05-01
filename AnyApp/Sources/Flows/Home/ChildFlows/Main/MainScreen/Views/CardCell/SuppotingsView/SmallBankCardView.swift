//
//  SmallBankCardView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class SmallBankCardView: BackgroundPrimary {
    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        let imageView = ImageView(image: Asset.MiniBankCard.bankCard.image)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                        .masksToBounds(true)
                        .cornerRadius(4)
                        .contentMode(.scaleToFill)
        let content = VStack(alignment: .trailing, distribution: .fill, spacing: 1) {
            Label()
                .text(props.cardNumber)
                .fontStyle(.caption11)
                .textColor(.white)
            ImageView(image: props.iconBank)
        }
        .layoutMargins(.init(top: 2, left: 0, bottom: 2, right: 4))

        content.embed(in: imageView)
        return imageView
    }
}

// MARK: - Configurable
extension SmallBankCardView: ConfigurableView {
    typealias Model = Props

    struct Props: Hashable {
        private let number: String
        private let image: Card.PaymentSystem

        public let status: Card.Status
        public var cardNumber: String {
            let endIndex = number.index(number.startIndex, offsetBy: 4)
            let range = Range(uncheckedBounds: (lower: number.startIndex, upper: endIndex))
            return String(number[range])
        }
        public var iconBank: UIImage {
            switch image {
            case .visa:
                return Asset.SmallIcon.visa.image
            case .masterCard:
                return Asset.SmallIcon.masterCard.image
            case .mir:
                return UIImage()
            }
        }

        init(number: String, iconBankImage: Card.PaymentSystem, status: Card.Status) {
            self.number = number
            self.image = iconBankImage
            self.status = status
        }

        public static func == (lhs: SmallBankCardView.Props, rhs: SmallBankCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(number)
            hasher.combine(image)
            hasher.combine(status)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
