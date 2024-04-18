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

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    func body() -> UIView {
        VStack {
            MainNavigationBar()
                .setuptile(title: "O приложения")
            ZStack(positioningMode: .center) {
                VStack(alignment: .center, distribution: .fill, spacing: 16) {
                    ImageView(image: Asset.logoL.image)
                    Label(text: "Версия 0.0.1 beta")
                        .foregroundStyle(.contentAccentSecondary)
                        .fontStyle(.caption11)
                }
            }
        }
        .layoutMargins(.make(hInsets: 16))
    }
}
