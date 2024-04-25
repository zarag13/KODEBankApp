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
        case shimmerCell(_ identifier: String = UUID().uuidString)
        case shimmerHeader(_ identifier: String = UUID().uuidString)
        case header(TemplateHeaderView.Props)
        case account(TemplateAccountView.Props)
        case card(TemplateCardView.Props)
        case deposit(TemplateDepositsView.Props)
        case spacer(BaseTableSpacer.Props)
        case error(ErrorDownloadCell.Props)
    }

    let sections: [Section]
}
