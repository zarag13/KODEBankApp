//
//  SmallBankCardView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent

final class SmallBankCardView: BackgroundPrimary {

    private var props: Props?
    
    let cardNumberLabel = Label()

    // MARK: - Public methods
    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        ZStack(positioningMode: .fill) {
            VStack {
                ImageView(image: props.backgroundCardImage)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            VStack(alignment: .trailing, distribution: .fill, spacing: 1) {
                cardNumberLabel
                    .text(props.cardNumber)
                    .fontStyle(.caption11)
                ImageView(image: props.iconBankImage)
            }
            .layoutMargins(.init(top: 2, left: 0, bottom: 1, right: 4))
        }
    }
}

// MARK: - Configurable
extension SmallBankCardView: ConfigurableView {
    

    typealias Model = Props

    struct Props: Hashable {
        
        enum State {
            case unavailabil
            case availabil
        }
        
        let cardNumber: String
        let backgroundCardImage: UIImage
        let iconBankImage: UIImage

        public static func == (lhs: SmallBankCardView.Props, rhs: SmallBankCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(cardNumber)
            hasher.combine(backgroundCardImage)
            hasher.combine(iconBankImage)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        if model.backgroundCardImage == Asset.MiniBankCard.bankCardDisable.image {
            cardNumberLabel.foregroundStyle(.textSecondary)
        }
        body(with: model).embed(in: self)
    }
}

