//
//  SettingsStackView.swift
//  AnyApp
//
//  Created by Kirill on 15.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

enum SettingsInfo {
    case settingInfo(image: UIImage, title: String, isDetailed: Bool)
}

final class SettingsStackView: BackgroundPrimary {
    private var settingsInfo: [SettingsInfo] = [
        .settingInfo(image: Asset.settings.image, title: "О приложении", isDetailed: true),
        .settingInfo(image: Asset.month.image, title: "Тема приложения", isDetailed: true),
        .settingInfo(image: Asset.phone.image, title: "Служба поддержки", isDetailed: false),
        .settingInfo(image: Asset.share.image, title: "Выход", isDetailed: false)
    ]

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        ForEach(collection: settingsInfo, alignment: .fill, distribution: .fillEqually, spacing: 18, axis: .vertical) { value in
            SettingView()
                .configure2(settingsInfo: value)
        }
        .layoutMargins(.make(vInsets: 18))
    }
}
