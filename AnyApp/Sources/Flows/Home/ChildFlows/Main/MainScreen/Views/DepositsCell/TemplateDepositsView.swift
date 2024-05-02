//
//  TemplateDepositsView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class TemplateDepositsView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundSecondary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            self.setupLeftIcon(image: props.leftImage)
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Label(text: props.title, foregroundStyle: .textPrimary, fontStyle: .body15r)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    Label(text: props.percentStake, foregroundStyle: .textTertiary, fontStyle: .caption11)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                }
                HStack(alignment: .center) {
                    Label(text: props.balance, foregroundStyle: .contentAccentPrimary, fontStyle: .body15r)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    Label(text: props.date, foregroundStyle: .textTertiary, fontStyle: .caption11)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                }
            }
                .huggingPriority(.defaultLow, axis: .horizontal)
        }
        .layoutMargins(.make(vInsets: 14, hInsets: 16))
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
            SnackCenter.shared.showSnack(withProps: .init(message: Main.depositsSnak, style: .basic))

            self?.props?.onTap?("\(props.id)")
        }
    }

    private func setupLeftIcon(image: UIImage) -> UIView {
        BackgroundView() {
            ImageView(image: image)
                .foregroundStyle(.textPrimary)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .backgroundColor(.clear)
        }
        .backgroundStyle(.contentSecondary)
        .masksToBounds(true)
        .cornerRadius(20)
    }
}

// MARK: - Configurable
extension TemplateDepositsView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let networkProps: Deposit
        var id: Int {
            networkProps.depositID
        }
        var title: String {
            networkProps.name
        }
        var balance: String {
            switch networkProps.currency {
            case .rub:
                let nf = NumberFormatter()
                nf.minimumFractionDigits = 2
                nf.maximumFractionDigits = 2
                nf.numberStyle = .decimal
                nf.locale = Locale.current
                return "\(nf.string(from: networkProps.balance as NSNumber) ?? "0") ₽"
            }
        }
        var leftImage: UIImage {
            switch networkProps.currency {
            case .rub:
                return Asset.Icon40px.rub.image
            }
        }
        let percentStake: String
        let date: String
        var onTap: StringHandler?

        public static func == (lhs: TemplateDepositsView.Props, rhs: TemplateDepositsView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(balance)
            hasher.combine(leftImage)
            hasher.combine(percentStake)
            hasher.combine(date)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
