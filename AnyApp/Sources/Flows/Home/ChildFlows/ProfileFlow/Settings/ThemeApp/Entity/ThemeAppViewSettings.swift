//
//  ThemeAppViewSettings.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import Foundation
import UI

struct ThemeAppViewSettings: Equatable {
    let title: String
    let event: ThemeRaw

    static var createItems: [ThemeAppViewSettings] {
        return [
            .init(title: Profile.system, event: .auto),
            .init(title: Profile.dark, event: .dark),
            .init(title: Profile.light, event: .light)
        ]
    }
}
