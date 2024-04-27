//
//  Event+typealias.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UIKit

struct ModelSettingsView {
    enum Event: String {
        case aboutApp
        case themeApp
        case supportService
        case exit
    }

    let image: UIImage
    let title: String
    let isDetailedImage: Bool
    let state: Event

    static var createItems: [ModelSettingsView] {
        return [
            .init(image: Asset.Icon24px.settings.image, title: Profile.aboutApp, isDetailedImage: true, state: .aboutApp),
            .init(image: Asset.Icon24px.moonStars.image, title: Profile.themeApp, isDetailedImage: true, state: .themeApp),
            .init(image: Asset.Icon24px.phoneCall.image, title: Profile.supportService, isDetailedImage: false, state: .supportService),
            .init(image: Asset.Icon24px.accountOut.image, title: Profile.exit, isDetailedImage: false, state: .exit)
        ]
    }
}
