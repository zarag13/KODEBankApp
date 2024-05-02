//
//  DetailCardHeaderView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent
import Services
import Combine

final class DetailCardHeaderView: BackgroundPrimary {

    private var props: Props?
    private var numberState = CurrentValueSubject<DetailCardHeaderView.NumberState, Never>(.close)
    private var cancelable = Set<AnyCancellable>()

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
                .cornerRadius(10)
        }
            .layoutMargins(.make(hInsets: 20))
            .shadowColor(.black)
            .shadowOffset(.init(width: 7, height: 7))
            .shadowRadius(26)
            .shadowOpacity(0.4)

        let content = VStack {
            Spacer(.px32)
            HStack(spacing: 16) {
                ImageView(image: props.companyCard)
                    .width(32)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                    .foregroundStyle(.contentSecondary)
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
                createNumberLabnel()
                Label(text: props.dateCard)
                    .fontStyle(.caption13)
                    .foregroundStyle(.textSecondary)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            Spacer(.px32)
        }
            .layoutMargins(.make(hInsets: 48))
            .backgroundColor(.clear)
        content.embed(in: imageView)
        return imageView
    }

    private func createNumberLabnel() -> UIView {
        let numberLabel = Label()
            .fontStyle(.caption13)
            .textAlignment(.left)
            .foregroundStyle(.textSecondary)
            .huggingPriority(.defaultLow, axis: .horizontal)

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
extension DetailCardHeaderView: ConfigurableView {

    enum NumberState {
        case open
        case close
    }

    typealias Model = Props

    struct Props: Hashable {
        let networkProps: DetailCard
        var id: Int {
            return networkProps.id
        }
        let title: String
        let sumMoney: String
        var numberCard: String {
            return networkProps.number
        }
        var dateCard: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            if let date = dateFormatter.date(from: networkProps.expiredAt) {
                dateFormatter.dateFormat = "MM/yy"
                return dateFormatter.string(from: date)
            }
            return networkProps.expiredAt
        }
        let styleCard: UIImage
        var companyCard: UIImage {
            switch networkProps.paymentSystem {
            case .visa:
                return Asset.SmallIcon.visa.image
            }
        }
        var rightImage: UIImage {
            return Asset.Icon24px.payPass.image
        }
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

        func toggleNumberMask(state: NumberState) -> String {
            switch state {
            case .open:
                return numberCard.maskPhoneNumber(pattern: "#### #### #### ####")
            case .close:
                let endIndex = numberCard.endIndex
                let startIndex = numberCard.index(endIndex, offsetBy: -4)
                let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
                let number = String(numberCard[range])
                return number.maskPhoneNumber(pattern: "**** ####")
            }
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
