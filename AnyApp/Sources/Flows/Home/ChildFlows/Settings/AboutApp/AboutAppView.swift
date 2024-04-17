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
            VStack {
                MainNavigationBar()
                    .setuptile(title: "O приложения")
                View().height(99)
                VStack(alignment: .center, distribution: .fill, spacing: 16) {
                    ImageView(image: Asset.logoL.image)
                    Label(text: "Версия 0.0.1 beta")
                        .fontStyle(.button)
                        .textColor(try? UIColor(hexString: "F678BA"))
                }
                FlexibleSpacer()
            }
        }
        .layoutMargins(.make(hInsets: 16))
    }
}
