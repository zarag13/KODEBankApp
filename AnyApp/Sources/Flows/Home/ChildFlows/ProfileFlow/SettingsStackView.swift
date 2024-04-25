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
    typealias SettingViewAction = ((ModelSettingsView.Event) -> Void)

    var action: SettingViewAction?
    private var settingsViews: [SettingView] = []

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupBindings()
    }

    private func body() -> UIView {
        ScrollView(axis: .vertical) {
            ForEach(collection: ModelSettingsView.createItems, alignment: .fill, distribution: .fillEqually, axis: .vertical) { value in
                self.cresteSettingView()
                    .configure2(settingsInfo: value)
            }
        }
    }

    private func cresteSettingView() -> SettingView {
        let settingsView = SettingView()
        settingsViews.append(settingsView)
        return settingsView
    }

    private func setupBindings() {
        for view in settingsViews {
            view
                .onTap { [weak view] in
                    guard let state = view?.state else { return }
                    UIView.animate(withDuration: 0.1) {
                        view?.alpha = 0.2
                    } completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            view?.alpha = 1
                        }
                    }
                    self.action?(state)
                }
        }
    }
}
