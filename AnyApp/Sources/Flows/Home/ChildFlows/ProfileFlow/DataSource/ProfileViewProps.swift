//
//  ProfileViewProps.swift
//  AnyApp
//
//  Created by Kirill on 29.04.2024.
//

import Foundation
import UI

struct ProfileViewProps {

    enum Section: Hashable {
        case detailHeader([Item])
        case settings([Item])

        var items: [Item] {
            switch self {
            case .settings(let items), .detailHeader(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case settingShimmer(_ identifier: String = UUID().uuidString)
        case detailInfoShimmer(_ identifier: String = UUID().uuidString)
        case detailInfo(DetailInfoView.Props)
        case settings(SettingView.Props)
    }
    let sections: [Section]
}
