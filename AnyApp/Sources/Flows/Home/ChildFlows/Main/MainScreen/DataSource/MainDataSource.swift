import UIKit
import UI

final class MainDataSource {

    typealias Section = MainViewProps.Section
    typealias Item = MainViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties
    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: MainCellFactory

    // MARK: - Init
    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = MainCellFactory(tableView: tableView)
        setup()
        configure()
    }

    // MARK: - Public Methods
    public func apply(sections: [Section]) {
        var snap = NSDiffableDataSourceSnapshot<Section, Item>()
        snap.appendSections(sections)
        sections.forEach {
            snap.appendItems($0.items, toSection: $0)
        }
        dataSource?.apply(snap, animatingDifferences: false)
    }

    public func applyNewItemInSection(nweItems: [Item], into section: Item) {
        guard let source = dataSource else { return }
        var snaphot = source.snapshot()
        let section = snaphot.sectionIdentifier(containingItem: section)
        snaphot.appendItems(nweItems, toSection: section)
        dataSource?.apply(snaphot, animatingDifferences: false)
    }

    public func closeNewItemInSection(nweItems: [Item]) {
        guard let source = dataSource else { return }
        var snaphot = source.snapshot()
        snaphot.deleteItems(nweItems)
        dataSource?.apply(snaphot, animatingDifferences: false)
    }

    // MARK: - Private methods
    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: TemplateShimmerView.self)
        tableView.registerTemplateCell(forView: TemplateCardView.self)
        tableView.registerTemplateCell(forView: TemplateAccountView.self)
        tableView.registerTemplateCell(forView: TemplateDepositsView.self)
        tableView.registerTemplateCell(forView: TemplateHeaderView.self)
        tableView.registerTemplateCell(forView: BaseTableSpacer.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .shimmer:
                return cellFactory.makeShimmer(for: indexPath)
            case .header(let props):
                return cellFactory.makeTemplateHeaderCell(for: indexPath, with: props)
            case .account(let props):
                return cellFactory.makeTemplateAccountCell(for: indexPath, with: props)
            case .card(let props):
                return cellFactory.makeTemplateCardCell(for: indexPath, with: props)
            case .deposit(let props):
                return cellFactory.makeTemplateDepositeCell(for: indexPath, with: props)
            case .spacer(let props):
                return cellFactory.makeSpacerSections(for: indexPath, with: props)
            }
        }
    }
}
