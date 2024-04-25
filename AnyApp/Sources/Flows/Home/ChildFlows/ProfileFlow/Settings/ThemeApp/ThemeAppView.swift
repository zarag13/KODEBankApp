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
            navigationBar
                .setuptile(title: Profile.themeApp)
            themeAppStackView
        }
            .layoutMargins(.make(hInsets: 16))
    }
}
