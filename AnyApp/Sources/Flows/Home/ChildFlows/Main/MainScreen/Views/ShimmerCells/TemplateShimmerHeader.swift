//
//  TemplateShimmerHeader.swift
//  AnyApp
//
//  Created by Kirill on 24.04.2024.
//

import UIKit
import UI
import AppIndependent

final class TemplateShimmerHeader: BackgroundPrimary {

    // MARK: - Public methods

    override public func setup() {
        super.setup()
        body().embed(in: self)
    }

    // MARK: - Private methods

    private func body() -> UIView {
        HStack {
            Shimmer(style: .default)
                .width(72)
                .skeletonCornerRadius(7)
            FlexibleSpacer()
        }
        .layoutMargins(.init(top: 19, left: 16, bottom: 19, right: 0))
        .height(52)
    }
}
