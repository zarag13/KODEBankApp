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

enum ThemeAppViewSettingsContent: Equatable {
    case content(title: String, event: Event)

    enum Event {
        case light
        case dark
        case system
    }
}

final class ThemeAppStackView: BackgroundPrimary {

    typealias Event = ((ThemeAppViewSettingsContent.Event) -> Void)
    var onEvent: Event?

    private var cancellable = Set<AnyCancellable>()
    private var currentIsSelectedView = CurrentValueSubject<ThemeAppViewSettingsContent.Event, Never>(.system)

    private var contents: [ThemeAppViewSettingsContent] = [
        .content(title: "Как в системе", event: .system),
        .content(title: "Темная", event: .dark),
        .content(title: "Светлая", event: .light)
    ]

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack {
            #warning("Здесь надо будет вынести MainNavigationBar и сделать эту view как отдельную- отвечает только за создание ячейки")
            MainNavigationBar()
                .setuptile(title: "Тема приложения")
            ForEach(collection: contents, alignment: .fill, distribution: .fill, spacing: 0, axis: .vertical) { content in
                self.setupThemeAppView(content: content)
            }
            FlexibleSpacer()
        }
        .layoutMargins(.make(hInsets: 16))
    }

    private func setupThemeAppView(content: ThemeAppViewSettingsContent) -> ThemeAppView {
        let themeAppView = ThemeAppView()
        themeAppView.onTap {
            guard let event = themeAppView.event else { return }
            self.currentIsSelectedView.send(event)
            #warning("Здесь будем посылать case Event в основную view а та будет посылать в ViewModel а ViewModel будет на основе Event делать запрос на изменение цвета системы")
        }

        currentIsSelectedView.sink { event in
            if themeAppView.event == event {
                themeAppView.isSelected.send(true)
            } else {
                themeAppView.isSelected.send(false)
            }
        }.store(in: &cancellable)

        if self.contents.last == content {
            themeAppView.separatorIfNeeded = false
        }

        return themeAppView.configure(content: content)
    }
}

final class ThemeAppView: BackgroundPrimary {
    public var isSelected = CurrentValueSubject<Bool, Never>(false)
    private var cancellable = Set<AnyCancellable>()
    @Published public var separatorIfNeeded = true
    public var event: ThemeAppViewSettingsContent.Event?
    override func setup() {
        super.setup()
    }

    private func body(title: String, event: ThemeAppViewSettingsContent.Event) -> UIView {
        VStack {
            HStack {
                Label(text: title)
                    .fontStyle(.body15r)
                    .foregroundStyle(.contentAccentTertiary)
                    .huggingPriority(.defaultLow, axis: .horizontal)
                setupImage()
                    .huggingPriority(.defaultHigh, axis: .horizontal)
            }
            .layoutMargins(.make(vInsets: 16))
            createSeparator()
        }
    }

    private func setupImage() -> ImageView {
        let imageView = ImageView(foregroundStyle: .textSecondary)
        isSelected.sink { state in
            if state {
                imageView.image = Asset.Icon24px.radioOn.image
            } else {
                imageView.image = Asset.Icon24px.radioOff.image
            }
        }.store(in: &cancellable)
        return imageView
    }

    private func createSeparator() -> UIView {
        let separator = View()
        separator.backgroundColor(ForegroundStyle.contentSecondary.color)
        separator.height(1)
        $separatorIfNeeded.sink { value in
            if value {
                separator.isHidden = false
            } else {
                separator.isHidden = true
            }
        }.store(in: &cancellable)
        return separator
    }

    public func configure(content: ThemeAppViewSettingsContent) -> Self {
        switch content {
        case .content(title: let title, event: let event):
            self.event = event
            body(title: title, event: event).embed(in: self)
        }
        return self
    }
}
