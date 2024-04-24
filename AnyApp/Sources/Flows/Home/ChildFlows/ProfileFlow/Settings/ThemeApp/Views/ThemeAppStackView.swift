//
//  ThemeAppStackView.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ThemeAppStackView: BackgroundPrimary {

    typealias Event = ((ThemeRaw) -> Void)
    var onEvent: Event?

    private var cancellable = Set<AnyCancellable>()
    private var currentIsSelectedView = PassthroughSubject<ThemeRaw, Never>()

    private var content: [ThemeAppViewSettingsContent] = [
        .content(title: "Как в системе", event: .auto),
        .content(title: "Темная", event: .dark),
        .content(title: "Светлая", event: .light)
    ]

    override func setup() {
        super.setup()
        body().embed(in: self)
        currentIsSelectedView.send(AppearanceManager.shared.themeRaw)
    }

    private func body() -> UIView {
        VStack {
            ForEach(collection: content, alignment: .fill, distribution: .fill, spacing: 0, axis: .vertical) { value in
                self.setupThemeAppView(content: value)
            }
            FlexibleSpacer()
        }
    }
}

private extension ThemeAppStackView {
    private func setupThemeAppView(content: ThemeAppViewSettingsContent) -> ThemeAppViewCell {
        let themeAppView = ThemeAppViewCell()
            .configure(content: content)

        themeAppView.onTap { [weak self, weak themeAppView] in
            guard let event = themeAppView?.event else { return }
            self?.currentIsSelectedView.send(event)
            self?.onEvent?(event)
        }

        currentIsSelectedView.sink { [weak themeAppView] event in
            if themeAppView?.event == event {
                themeAppView?.isSelected.send(true)
            } else {
                themeAppView?.isSelected.send(false)
            }
        }.store(in: &cancellable)

        if self.content.last == content {
            themeAppView
                .separatorIsHidden(true)
        }

        return themeAppView
    }
}
