//
//  DetailAccountViewProps.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import Foundation
import UI

struct DetailAccountViewProps {

    enum Section: Hashable {
        case detailHeader([Item])
        case history([Item])

        var items: [Item] {
            switch self {
            case .history(let items), .detailHeader(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimmer(_ identifier: String = UUID().uuidString)
        case header(TemplateHeaderView.Props)
        case history(HistoryAccountView.Props)
        case settings(SettingsAccountView.Props)
        case favorites(FavoritesAccountView.Props)
        case spacer(BaseTableSpacer.Props)
        case actions(ActionsTabsView.Props)
        case card(DetailCardHeaderView.Props)
        case account(DetailAccountHeaderView.Props)
    }

    let sections: [Section]
}
