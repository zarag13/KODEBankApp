//
//  SettingsShimerStackView.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class SettingsShimerStackView: BackgroundPrimary {

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        ScrollView(axis: .vertical, padding: 0) {
            ForEach(collection: ModelSettingsView.createItems, alignment: .fill, distribution: .fillEqually, axis: .vertical) { _ in
                SettingShimerView()
            }
        }
    }
}
