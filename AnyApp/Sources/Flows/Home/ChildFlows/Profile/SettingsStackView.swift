//
//  SettingsStackView.swift
//  AnyApp
//
//  Created by Kirill on 15.04.2024.
//

import UI
import UIKit
import AppIndependent

final class SettingsStackView: BackgroundPrimary {
    private var settingsInfo: [SettingsInfo] = [
        .settingInfo(image: Asset.Icon24px.settings.image, title: "О приложении", isDetailed: true, state: .none),
        .settingInfo(image: Asset.Icon24px.moonStars.image, title: "Тема приложения", isDetailed: true, state: .none),
        .settingInfo(image: Asset.Icon24px.phoneCall.image, title: "Служба поддержки", isDetailed: false, state: .none),
        .settingInfo(image: Asset.Icon24px.accountOut.image, title: "Выход", isDetailed: false, state: .none)
    ]

    var action: SettingViewAction?
    var settingsViews: [SettingView] = []

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupBindings()
    }

    private func body() -> UIView {
        ScrollView(axis: .vertical) {
            ForEach(collection: settingsInfo, alignment: .fill, distribution: .fillEqually, spacing: 18, axis: .vertical) { value in
                self.cresteSettingView()
                    .configure2(settingsInfo: value)
            }
        }
            .layoutMargins(.make(vInsets: 18))
    }

    func cresteSettingView() -> SettingView {
        let settingsView = SettingView()
        settingsViews.append(settingsView)
        return settingsView
    }

    func setupBindings() {
        for view in settingsViews {
            view
                .onTap {
                    self.action?(view.state)
                }
        }
    }
}
