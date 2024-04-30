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
        case loadView
    }
    enum Output {
        case themeCells([ThemeAppViewCell.Props])
    }

    // MARK: - Public Properties
    public var onEvent: ((Output) -> Void)?

    // MARK: - Private Methods
    private func eventForThemeCell(_ theme: ThemeRaw) {
        AppearanceManager.shared.setTheme(theme)
    }

    // MARK: - Public Methods
    public func handle(_ input: Input) {
        switch input {
        case .loadView:
            self.onEvent?(.themeCells([
                .init(title: Profile.system, event: .auto, onTap: eventForThemeCell),
                .init(title: Profile.dark, event: .dark, onTap: eventForThemeCell),
                .init(title: Profile.light, event: .light, onTap: eventForThemeCell)
                
            ]))
        }
    }
}
