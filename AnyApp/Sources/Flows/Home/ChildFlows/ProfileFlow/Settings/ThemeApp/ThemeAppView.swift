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

    // MARK: - Private Properties
    private let themeAppStackView = ThemeAppStackView()

    // MARK: - Private Methods
    private func body(with props: [ThemeAppViewCell.Props]) -> UIView {
        VStack {
            themeAppStackView
                .configure(with: props)
            FlexibleSpacer()
        }
            .layoutMargins(.make(hInsets: 16))
    }

    // MARK: - Public Methods
    public func configure(with props: [ThemeAppViewCell.Props]) {
        subviews.forEach { $0.removeFromSuperview() }
        body(with: props).embed(in: self)
    }
}
