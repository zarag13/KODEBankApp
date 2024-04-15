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
            ImageView(image: Asset.detail.image)
                .huggingPriority(.defaultHigh, axis: .horizontal)
                .isHidden(!isDetailed)
        }
    }

//    public func configure(image: UIImage, settingName: String, isDetailed: Bool) -> Self {
//        self.setiingIcon = image
//        self.settingName = settingName
//        self.isDetailed = isDetailed
//        body().embed(in: self)
//        return self
//    }

    public func configure2(settingsInfo: SettingsInfo) -> Self {
        switch settingsInfo {
        case .settingInfo(image: let image, title: let title, isDetailed: let isDetailed):
            self.setiingIcon = image
            self.settingName = title
            self.isDetailed = isDetailed
        }
        body().embed(in: self)
        return self
    }
}
