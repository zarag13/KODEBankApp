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

    var navigationBar = MainNavigationBar()

    override func setup() {
        super.setup()
    }

    func body(version: String) -> UIView {
        VStack {
            navigationBar
                .setuptile(title: Profile.aboutApp)
            ZStack(positioningMode: .center) {
                VStack(alignment: .center, distribution: .fill, spacing: 16) {
                    ImageView(image: Asset.logoL.image)
                        .foregroundStyle(.contentAccentTertiary)
                    Label(text: "\(Profile.version) \(version) beta")
                        .foregroundStyle(.contentAccentSecondary)
                        .fontStyle(.caption11)
                }
            }
        }
        .layoutMargins(.make(hInsets: 16))
    }

    @discardableResult
    public func configure(version: String) -> Self {
        body(version: version).embed(in: self)
        return self
    }
}
