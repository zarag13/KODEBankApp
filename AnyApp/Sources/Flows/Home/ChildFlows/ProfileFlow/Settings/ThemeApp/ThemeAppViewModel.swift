//
//  ThemeAppViewModel.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import Services
import Combine
import UI

final class ThemeAppViewModel {

    enum Input {
        case themeApp(ThemeRaw)
    }

    func handle(_ input: Input) {
        switch input {
        case .themeApp(let theme):
            AppearanceManager.shared.setTheme(theme)
        }
    }
}
