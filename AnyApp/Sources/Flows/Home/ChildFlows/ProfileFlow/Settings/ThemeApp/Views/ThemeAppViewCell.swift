//
//  ThemeAppViewCell.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ThemeAppViewCell: BackgroundPrimary {

    public var event: ThemeRaw?

    private let separator = View()

    private var cancellable = Set<AnyCancellable>()
    var isSelected = PassthroughSubject <Bool, Never>()

    override func setup() {
        super.setup()
    }

    private func body(title: String) -> UIView {
        VStack {
            HStack {
                Label(text: title)
                    .fontStyle(.body15r)
                    .foregroundStyle(.contentAccentTertiary)
                    .huggingPriority(.defaultLow, axis: .horizontal)
                setupCheckBox()
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            .layoutMargins(.make(vInsets: 16))
            separator
                .backgroundColor(ForegroundStyle.contentSecondary.color)
            separator.height(1)
        }
    }

    private func setupCheckBox() -> ImageView {
        let imageView = ImageView(foregroundStyle: .textSecondary)

        isSelected.sink { [weak imageView] value in
            if value {
                imageView?.image = Asset.Icon24px.radioOn.image
            } else {
                imageView?.image = Asset.Icon24px.radioOff.image
            }
        }.store(in: &cancellable)
        return imageView
    }

    @discardableResult
    public func separatorIsHidden(_ isHidden: Bool) -> Self {
        separator.isHidden = isHidden
        return self
    }

    @discardableResult
    public func configure(content: ThemeAppViewSettings) -> Self {
        self.event = content.event
        body(title: content.title).embed(in: self)
        return self
    }
}
