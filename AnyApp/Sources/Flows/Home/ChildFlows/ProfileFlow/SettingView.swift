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
    var state: ModelSettingsView.Event?

    override func setup() {
        super.setup()
    }

    private var setiingIcon = UIImage()
    private var settingName = String()
    private var isDetailed = false

    private func body() -> UIView {
        HStack(spacing: 16) {
            ImageView(image: setiingIcon)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .foregroundStyle(.textTertiary)
            Label(text: settingName)
                .fontStyle(.body15r)
                .foregroundStyle(.textPrimary)
                .huggingPriority(.defaultLow, axis: .horizontal)
            ImageView(image: Asset.Icon24px.chevronRight.image)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .isHidden(!isDetailed)
                .foregroundStyle(.textTertiary)
        }
        .layoutMargins(.make(vInsets: 16))
    }

    public func configure2(settingsInfo: ModelSettingsView) -> Self {
        self.setiingIcon = settingsInfo.image
        self.settingName = settingsInfo.title
        self.isDetailed = settingsInfo.isDetailedImage
        self.state = settingsInfo.state
        body().embed(in: self)
        return self
    }
}
