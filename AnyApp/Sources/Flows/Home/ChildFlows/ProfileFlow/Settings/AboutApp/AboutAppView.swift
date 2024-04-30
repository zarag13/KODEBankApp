//
//  AboutAppView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AboutAppView: BackgroundPrimary {

    // MARK: - Private Methods
    private func body(version: String) -> UIView {
        VStack {
            ImageView(image: Asset.logoL.image)
                .foregroundStyle(.contentAccentTertiary)
            Spacer(.px16)
            Label(text: "\(Profile.version) \(version) beta")
                .foregroundStyle(.contentAccentSecondary)
                .fontStyle(.caption11)
                .textAlignment(.center)
            FlexibleSpacer()
        }
        .layoutMargins(.init(top: 99, left: 16, bottom: 0, right: 16))
    }

    // MARK: - Public Methods
    @discardableResult
    public func configure(version: String) -> Self {
        body(version: version).embed(in: self)
        return self
    }
}
