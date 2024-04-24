//
//  ThemeAppView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ThemeAppView: BackgroundPrimary {

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    let themeAppStackView = ThemeAppStackView()
    let navigationBar = MainNavigationBar()

    private func body() -> UIView {
        VStack {
#warning("Здесь надо будет вынести MainNavigationBar и сделать эту view как отдельную- отвечает только за создание ячейки")
            navigationBar
                .setuptile(title: "Тема приложения")
            themeAppStackView
        }
            .layoutMargins(.make(hInsets: 16))
    }
}
