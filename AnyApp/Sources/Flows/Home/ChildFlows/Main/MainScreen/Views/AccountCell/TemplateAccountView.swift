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

    private var props: Props?

    var rightImage = ImageView(image: Asset.Icon24px.chevronDown.image)

    enum State {
        case open
        case close
    }

    var state2 = CurrentValueSubject<State, Never>(.close)
    var cancelable = Set<AnyCancellable>()

    // MARK: - Public methods
    override public func setup() {
        super.setup()
        state2.sink { state in
            switch state {
            case .open:
                self.rightImage.image = Asset.Icon24px.chevronDown.image
            case .close:
                self.rightImage.image = Asset.Icon24px.chevronUp.image
            }
        }.store(in: &cancelable)
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
            VStack(alignment: .center, distribution: .fill) {
                VStack {
                    rightImage
                        .foregroundStyle(.contentTertiary)
                        .onTap {
                            [weak self] in
                               switch self?.state2.value {
                               case .open:
                                   self?.state2.send(.close)
                                   self?.props?.onTap?(props, .close)
                               case .close:
                                   self?.state2.send(.open)
                                   self?.props?.onTap?(props, .open)
                               case .none: break
                               }
                        }
                }
                .layoutMargins(.make(vInsets: 2))
            }
            .backgroundColor(ForegroundStyle.contentSecondary.color)
                .width(40)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .cornerRadius(3)
        }
        .layoutMargins(.init(top: 16, left: 16, bottom: 14, right: 16))
        .onTap { [weak self] in
            self?.props?.openTap?()
        }
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

        //var onTap: StringHandler?
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
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
    }
}
