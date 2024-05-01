//
//  TemplateCardView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent
import Services

final class TemplateCardView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundSecondary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        let stack = HStack(alignment: .center, distribution: .fill, spacing: 24) {
            ImageView(image: props.leftImage)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .foregroundStyle(.textTertiary)
            VStack(spacing: 5) {
                Label(text: props.title, foregroundStyle: .contentAccentTertiary, fontStyle: .body15r)
                setupDescription(props: props)
            }
                .huggingPriority(.defaultLow, axis: .horizontal)
            SmallBankCardView()
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .configured(with: props.smallBankCardImage)
        }
        .layoutMargins(.init(top: 16, left: 24, bottom: 17, right: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
        
//        let separator = setupSeparatorCell(id: props.id)
//        stack.addSubview(separator)
//        separator.snp.makeConstraints { make in
//            make.bottom.equalToSuperview()
//            make.left.equalToSuperview().offset(72)
//            make.right.equalToSuperview().inset(16)
//        }
        return stack
    }

    private func setupDescription(props: Props) -> Label {
        let label = Label(text: props.description, fontStyle: .caption13)
        switch props.networkProps.status {
        case .deactivated:
            label.foregroundStyle(.indicatorContentError)
        case .active:
            label.foregroundStyle(.textTertiary)
        }
       return label
    }

//    private func setupSeparatorCell(id: String) -> UIView {
//        guard let number = Int(id) else { return UIView() }
//        let separator = BackgroundView()
//            .height(1)
//            .backgroundStyle(.contentSecondary)
//            .isHidden(false)
//        if number % 2 != 0 {
//            separator
//                .isHidden(true)
//        }
//        return separator
//    }
}

// MARK: - Configurable
extension TemplateCardView: ConfigurableView {
    typealias Model = Props

    struct Props: Hashable {

        let networkProps: Card
        var id: String {
            return networkProps.cardID
        }
        var title: String {
            return networkProps.name
        }
        let accountId: Int
        let cardNumber: String
        public var smallBankCardImage: SmallBankCardView.Props {
            return .init(
                number: cardNumber,
                iconBankImage: networkProps.paymentSystem,
                status: networkProps.status
            )
        }
        public var description: String {
            switch networkProps.cardType {
            case .physical: "Физическая"
            case .digital: "Виртуальная"
            }
        }
        let leftImage = Asset.Icon24px.input.image

        var onTap: StringHandler?

        public static func == (lhs: TemplateCardView.Props, rhs: TemplateCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
