//
//  DetailAccountDataSource.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UIKit
import UI

final class DetailAccountDataSource {

    typealias Section = DetailAccountViewProps.Section
    typealias Item = DetailAccountViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties
    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: DetailAccountCellFactory

    // MARK: - Init
    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = DetailAccountCellFactory(tableView: tableView)
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
    
    public func applyNewItem(items: Section) {
        guard let source = dataSource else { return }
        var snaphot = source.snapshot()
        if snaphot.sectionIdentifiers.count >= 2 {
            let lastSect = snaphot.sectionIdentifiers.last
            snaphot.deleteSections([lastSect!])
        }
        snaphot.appendSections([items])
        snaphot.appendItems(items.items, toSection: items)
        print(snaphot.sectionIdentifiers.count)
        dataSource?.apply(snaphot, animatingDifferences: false)
    }

    // MARK: - Private methods
    private func setup() {
        tableView.contentInsets(.init(top: 16, left: 0, bottom: 92, right: 0))
        tableView.registerTemplateCell(forView: TemplateShimmerView.self)
        tableView.registerTemplateCell(forView: TemplateHeaderView.self)
        tableView.registerTemplateCell(forView: BaseTableSpacer.self)
        
        tableView.registerTemplateCell(forView: FavoritesAccountView.self)
        tableView.registerTemplateCell(forView: SettingsAccountView.self)
        tableView.registerTemplateCell(forView: HistoryAccountView.self)
        
        tableView.registerTemplateCell(forView: DetailCardHeaderView.self)
        tableView.registerTemplateCell(forView: ActionsTabsView.self)
        
        tableView.registerTemplateCell(forView: DetailAccountHeaderView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .shimmer:
                cellFactory.makeShimmer(for: indexPath)
            case .header(let props):
                cellFactory.makeTemplateHeaderCell(for: indexPath, with: props)
            case .history(let props):
                cellFactory.makeHistoryAccountCell(for: indexPath, with: props)
            case .settings(let props):
                cellFactory.makeSettingsAccountCell(for: indexPath, with: props)
            case .favorites(let props):
                cellFactory.makeFavoritesAccountCell(for: indexPath, with: props)
            case .spacer(let props):
                cellFactory.makeSpacerSections(for: indexPath, with: props)
            case .actions(let props):
                cellFactory.makeActionsTabsView(for: indexPath, with: props)
            case .card(let props):
                cellFactory.makeDetailCardHeaderView(for: indexPath, with: props)
            case .account(let props):
                cellFactory.makeDetailAccountHeaderView(for: indexPath, with: props)
            }
        }
    }
}
