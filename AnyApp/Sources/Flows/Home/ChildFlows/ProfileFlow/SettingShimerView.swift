//
//  SettingShimerView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UIKit
import UI
import AppIndependent

final class SettingShimerView: BackgroundPrimary {
    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private Methods
    private func body() -> UIView {
        VStack {
            View()
                .height(10)
            HStack(alignment: .center, distribution: .fill, spacing: 16) {
                Shimmer(style: .default)
                    .height(40)
                    .width(40)
                    .skeletonCornerRadius(20)
                Shimmer()
                    .height(16)
                    .skeletonCornerRadius(8)
            }
            Spacer(.px6)
        }
        .layoutMargins(.make(hInsets: 16))
    }
}
