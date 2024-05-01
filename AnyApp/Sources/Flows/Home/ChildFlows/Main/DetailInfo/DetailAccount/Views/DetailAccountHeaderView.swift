//
//  DetailAccountHeaderView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent
import Services
import Combine

final class DetailAccountHeaderView: BackgroundPrimary {

    // MARK: - Private Properties
    private var props: Props?
    private var numberState = CurrentValueSubject<DetailAccountHeaderView.NumberState, Never>(.close)
    private var cancelable = Set<AnyCancellable>()

    override func setup() {
        super.setup()
    }
    private func body(with props: Props) -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            Spacer(.px16)
            createTitleIcon(image: props.topImage)
            Spacer(.px16)
            Label(text: props.title)
                .fontStyle(.body15sb)
                .foregroundStyle(.textPrimary)
                .textAlignment(.center)
            Spacer(.px6)
            createNumberLabnel()
            Spacer(.px8)
            Label(text: props.balance)
                .fontStyle(.largeTitle)
                .textAlignment(.center)
                .foregroundStyle(.textPrimary)
            Spacer(.px16)
        }
    }

    private func createTitleIcon(image: UIImage) -> UIView {
        BackgroundView() {
            ImageView(image: image)
                .foregroundStyle(.textPrimary)
                .backgroundColor(.clear)
                .contentMode(.scaleAspectFill)
        }
        .height(52)
        .width(52)
        .backgroundStyle(.contentSecondary)
        .masksToBounds(true)
        .cornerRadius(26)
    }

    private func createNumberLabnel() -> UIView {
        let numberLabel = Label()
            .fontStyle(.caption13)
            .textAlignment(.center)
            .foregroundStyle(.textSecondary)

        numberState.sink { [weak numberLabel, weak self] state in
            switch state {
            case .open:
                numberLabel?.text(self?.props?.toggleNumberMask(state: .open))
            case .close:
                numberLabel?.text(self?.props?.toggleNumberMask(state: .close))
            }
        }.store(in: &cancelable)

        return BackgroundView(vPadding: 4) {
            numberLabel
        }
        .onTap { [weak self] in
            self?.numberState.value == .close ? self?.numberState.send(.open) : self?.numberState.send(.close)
        }
    }
}

// MARK: - Configurable
extension DetailAccountHeaderView: ConfigurableView {

    typealias Model = Props

    enum NumberState {
        case open
        case close
    }

    struct Props: Hashable {
        let networkProps: DetailAccount
        let title: String
        var  id: Int {
            networkProps.accountID
        }
        var topImage: UIImage {
            switch networkProps.currency {
            case .rub:
                return Asset.Icon40px.rub.image
            }
        }
        var cardNumber: String {
            return networkProps.number
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

        var onTap: StringHandler?

        public static func == (lhs: DetailAccountHeaderView.Props, rhs: DetailAccountHeaderView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(topImage)
            hasher.combine(cardNumber)
            hasher.combine(balance)
        }

        func toggleNumberMask(state: NumberState) -> String {
            switch state {
            case .open:
                return cardNumber.maskPhoneNumber(pattern: "#### #### #### ####")
            case .close:
                let endIndex = cardNumber.endIndex
                let startIndex = cardNumber.index(endIndex, offsetBy: -4)
                let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                let number = String(cardNumber[range])
                return number.maskPhoneNumber(pattern: "**** **** **** **** ####")
            }
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
