import Foundation
import UI

struct MainViewProps {

    enum Section: Hashable {
        case accounts([Item])
        case deposits([Item])

        var items: [Item] {
            switch self {
            case .accounts(let items),
                 .deposits(let items):
                return items
            }
        }
    }

    enum Item: Hashable {
        case shimmer(_ identifier: String = UUID().uuidString)
        case header(TemplateHeaderView.Props)
        case account(TemplateAccountView.Props)
        case card(TemplateCardView.Props)
        case deposit(TemplateDepositsView.Props)
        case spacer(BaseTableSpacer.Props)
    }

    let sections: [Section]
}
