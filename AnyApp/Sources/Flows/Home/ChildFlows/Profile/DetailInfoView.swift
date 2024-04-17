//
//  DetailInfoView.swift
//  AnyApp
//
//  Created by Kirill on 15.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class DetailInfoView: BackgroundPrimary {
    override func setup() {
        super.setup()
        body().embed(in: self)
    }
    private func body() -> UIView {
        VStack {
            ImageView(image: Asset.bitmap.image)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            Spacer(.px16)
            Label(text: "Филипп Ребийяр Олегович")
                .textAlignment(.center)
                .textColor(.white)
            Spacer(.px4)
            Label(text: "+7 (951) *** - ** - 24 ")
                .textAlignment(.center)
                .textColor(.white)
        }
    }
}
