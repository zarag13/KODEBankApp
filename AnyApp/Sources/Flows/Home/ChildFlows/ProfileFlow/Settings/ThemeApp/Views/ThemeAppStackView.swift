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
    // MARK: - Private Properties
    private var themeCells = [ThemeAppViewCell]()
    private var cancellable = Set<AnyCancellable>()
    private var curentTheme = CurrentValueSubject<ThemeRaw, Never>(AppearanceManager.shared.themeRaw)

    // MARK: - Private Methods
    private func body(with props: [ThemeAppViewCell.Props]) -> UIView {
        ForEach(collection: props, alignment: .fill, distribution: .fill, spacing: 0, axis: .vertical) { item in
            self.setupThemeCell()
                .configured(with: item)
        }
    }

    private func setupThemeCell() -> ThemeAppViewCell {
        let cell = ThemeAppViewCell()
        themeCells.append(cell)
        cell.onEvent = { [weak self] theme in
            self?.curentTheme.send(theme)
        }
        return cell
    }

    private func setupBindings() {
        curentTheme.sink { [weak self] theme in
            self?.themeCells.forEach { view in
                view.isSelected(theme)
            }
        }.store(in: &cancellable)
    }

    // MARK: - Public Methods
    @discardableResult
    public func configure(with props: [ThemeAppViewCell.Props]) -> Self {
        subviews.forEach { $0.removeFromSuperview() }
        body(with: props).embed(in: self)
        themeCells.last?.separatorIsHidden(true)
        setupBindings()
        return self
    }
}
