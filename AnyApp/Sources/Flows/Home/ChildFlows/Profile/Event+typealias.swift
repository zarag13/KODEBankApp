//
//  Event+typealias.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UIKit

typealias SettingViewAction = ((SettingViewEvent) -> Void)

enum SettingViewEvent: String {
    case aboutApp
    case themeApp
    case supportService
    case exit
    case none
}

enum SettingsInfo {
    case settingInfo(image: UIImage, title: String, isDetailed: Bool, state: SettingViewEvent)
}
