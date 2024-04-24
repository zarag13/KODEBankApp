//
//  TemplateCardView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateCardView: BackgroundPrimary {

    private var props: Props?

    // MARK: - Public methods
    override public func setup() {
        super.setup()
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
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
                .configured(with: props.rightImage)
        }
        .layoutMargins(.init(top: 16, left: 24, bottom: 17, right: 16))
        .onTap { [weak self] in
            self?.props?.onTap?(props.id)
        }
    }
    
    private func setupDescription(props: Props) -> Label {
        let label = Label(text: props.description, fontStyle: .caption13)
        switch props.state {
        case .unavailabil:
            label.foregroundStyle(.indicatorContentError)
        case .availabil:
            label.foregroundStyle(.textTertiary)
        }
       return label
    }
}

// MARK: - Configurable
extension TemplateCardView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        
        enum State {
            case unavailabil
            case availabil
        }
        
        let id: String
        let title: String
        let description: String
        let rightImage: SmallBankCardView.Props
        let leftImage: UIImage
        let state: State

        var onTap: StringHandler?

        public static func == (lhs: TemplateCardView.Props, rhs: TemplateCardView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(rightImage)
            hasher.combine(leftImage)
            hasher.combine(state)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}