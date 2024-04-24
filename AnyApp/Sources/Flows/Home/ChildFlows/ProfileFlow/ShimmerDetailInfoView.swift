//
//  ShimmerDetailInfoView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ShimmerDetailInfoView: BackgroundPrimary {
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    private func body() -> UIView {
        VStack(alignment: .center, distribution: .fill) {
            Shimmer()
                .size(width: 88, height: 88)
                .skeletonCornerRadius(44)
            Spacer(.px20)
            Shimmer()
                .size(width: 256, height: 18)
                .skeletonCornerRadius(9)
            Spacer(.px6)
            Shimmer()
                .size(width: 122, height: 16)
                .skeletonCornerRadius(8)
        }
    }
}
