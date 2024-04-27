//
//  TemplateAccountView.swift
//  AnyApp
//
//  Created by Kirill on 19.04.2024.
//

import UIKit
import UI
import AppIndependent
import Combine

final class TemplateAccountView: BackgroundPrimary {
    enum State {
        case open
        case close
    }

    private var props: Props?
    private var state = CurrentValueSubject<State, Never>(.open)
    private var cancelable = Set<AnyCancellable>()

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        self.backgroundStyle(.backgroundSecondary)
    }

    // MARK: - Private methods
    private func body(with props: Props) -> UIView {
        HStack(alignment: .center, distribution: .fill, spacing: 16) {
            ImageView(image: props.leftImage)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            VStack(spacing: 6) {
                Label(text: props.title, foregroundStyle: .contentAccentTertiary, fontStyle: .body15r)
                Label(text: props.description, foregroundStyle: .contentAccentPrimary, fontStyle: .body15r)
            }
                .huggingPriority(.defaultLow, axis: .horizontal)
            BackgroundView(vPadding: 2) {
                configureRightImage(props: props)
            }
            .backgroundStyle(.contentSecondary)
                .width(40)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .cornerRadius(3)
        }
        .layoutMargins(.init(top: 16, left: 16, bottom: 14, right: 16))
        .onTap { [weak self] in
            self?.props?.openTap?()
        }
    }

    private func configureRightImage(props: Props) -> ImageView {
        let rightImage = ImageView()
            .foregroundStyle(.contentTertiary)
            .onTap {
                [weak self] in
                   switch self?.state.value {
                   case .open:
                       self?.state.send(.close)
                       self?.props?.onTap?(props, .close)
                   case .close:
                       self?.state.send(.open)
                       self?.props?.onTap?(props, .open)
                   case .none: break
                   }
            }
        state.sink { [weak rightImage] state in
            switch state {
            case .open:
                rightImage?.image = Asset.Icon24px.chevronUp.image
            case .close:
                rightImage?.image = Asset.Icon24px.chevronDown.image
            }
        }.store(in: &cancelable)
        return rightImage
    }
}

// MARK: - Configurable
extension TemplateAccountView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        let title: String
        let description: String
        let leftImage: UIImage
        
        var onTap: ((Props, State) -> Void)?
        var openTap: (() -> Void)?

        public static func == (lhs: TemplateAccountView.Props, rhs: TemplateAccountView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(description)
            hasher.combine(leftImage)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body(with: model).embed(in: self)
    }
}
