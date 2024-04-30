//
//  SettingView.swift
//  AnyApp
//
//  Created by Kirill on 15.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class SettingView: BackgroundPrimary {
    // MARK: - Private Properties
    private var props: Props?

    override func setup() {
        super.setup()
    }

    private func body(with props: Props) -> UIView {
        VStack {
            Spacer(.px16)
                HStack(spacing: 16) {
                    ImageView(image: props.leftImage)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                        .foregroundStyle(.textTertiary)
                    Label(text: props.title)
                        .fontStyle(.body15r)
                        .foregroundStyle(.textPrimary)
                        .huggingPriority(.defaultLow, axis: .horizontal)
                    ImageView(image: Asset.Icon24px.chevronRight.image)
                        .huggingPriority(.defaultHigh, axis: .horizontal)
                        .isHidden(!props.isDetailedImage)
                        .foregroundStyle(.textTertiary)
                }
            Spacer(.px16)
        }
        .onTap {
            props.onTap?(props.event)
        }
        .layoutMargins(.make(hInsets: 16))
    }
}

// MARK: - Configurable
extension SettingView: ConfigurableView {
    enum Event: String {
        case aboutApp
        case themeApp
        case supportService
        case exit
    }

    public typealias EventHandler = ((Event) -> Void)
    public typealias Model = Props

    public struct Props: Hashable {
        public let id: Int
        public let title: String
        public let event: Event
        public let leftImage: UIImage
        public let isDetailedImage: Bool
        public var onTap: EventHandler?
        
        public init(
            id: Int,
            title: String,
            event: Event,
            leftImage: UIImage,
            isDetailedImage: Bool,
            onTap: EventHandler? = nil) {
                self.id = id
                self.title = title
                self.event = event
                self.leftImage = leftImage
                self.isDetailedImage = isDetailedImage
                self.onTap = onTap
            }
        public static func == (lhs: SettingView.Props, rhs: SettingView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(title)
            hasher.combine(event)
            hasher.combine(leftImage)
            hasher.combine(isDetailedImage)
        }
    }

    public func configure(with model: Model) {
        subviews.forEach { $0.removeFromSuperview() }
        self.props = model
        body(with: model).embed(in: self)
        self.layoutIfNeeded()
    }
}
