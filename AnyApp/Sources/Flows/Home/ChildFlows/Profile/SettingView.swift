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
    var state: SettingViewEvent = .none

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
            Label(text: settingName)
                .huggingPriority(.defaultLow, axis: .horizontal)
            ImageView(image: Asset.Icon24px.chevronRight.image)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .isHidden(!isDetailed)
        }
    }

    public func configure2(settingsInfo: SettingsInfo) -> Self {
        switch settingsInfo {
        case .settingInfo(image: let image, title: let title, isDetailed: let isDetailed, state: let state):
            self.setiingIcon = image
            self.settingName = title
            self.isDetailed = isDetailed
            self.state = state
        }
        body().embed(in: self)
        return self
    }
}
