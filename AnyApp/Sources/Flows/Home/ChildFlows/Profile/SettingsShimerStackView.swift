//
//  SettingsShimerStackView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class SettingsShimerStackView: BackgroundPrimary {
    private var settingsInfo: [SettingsInfo] = [
        .settingInfo(image: Asset.settings.image, title: "О приложении", isDetailed: true, state: .none),
        .settingInfo(image: Asset.month.image, title: "Тема приложения", isDetailed: true, state: .none),
        .settingInfo(image: Asset.phone.image, title: "Служба поддержки", isDetailed: false, state: .none),
        .settingInfo(image: Asset.share.image, title: "Выход", isDetailed: false, state: .none)
    ]

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        ScrollView(axis: .vertical, padding: 0) {
            ForEach(collection: settingsInfo, alignment: .fill, distribution: .fillEqually, axis: .vertical) { value in
                SettingShimerView()
            }
        }
    }
}
