//
//  ProfileDataSource.swift
//  AnyApp
//
//  Created by Kirill on 29.04.2024.
//

import UIKit
import UI

final class ProfileDataSource {

    typealias Section = ProfileViewProps.Section
    typealias Item = ProfileViewProps.Item
    typealias DiffableDataSource = UITableViewDiffableDataSource<Section, Item>

    // MARK: - Private properties
    public var dataSource: DiffableDataSource?
    private let tableView: BaseTableView
    private let cellFactory: ProfileCellFactory

    // MARK: - Init
    init(tableView: BaseTableView) {
        self.tableView = tableView
        self.cellFactory = ProfileCellFactory(tableView: tableView)
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

    public func applySettingSection(section: Section) {
        guard let source = dataSource else { return }
        var snaphot = source.snapshot()
        if snaphot.sectionIdentifiers.count >= 2 {
            guard let lastSect = snaphot.sectionIdentifiers.last else { return }
            snaphot.deleteSections([lastSect])
        }
        snaphot.appendSections([section])
        snaphot.appendItems(section.items, toSection: section)
        dataSource?.apply(snaphot, animatingDifferences: false)
    }

    // MARK: - Private methods
    private func setup() {
        tableView.contentInsets(.init(top: 0, left: 0, bottom: 0, right: 0))
        tableView.registerTemplateCell(forView: SettingShimerView.self)
        tableView.registerTemplateCell(forView: SettingView.self)
        tableView.registerTemplateCell(forView: ShimmerDetailInfoView.self)
        tableView.registerTemplateCell(forView: DetailInfoView.self)
    }

    private func configure() {
        dataSource = DiffableDataSource(tableView: tableView) { [unowned self] _, indexPath, item in
            switch item {
            case .settingShimmer:
                cellFactory.makeSettingsShimmer(for: indexPath)
            case .detailInfoShimmer:
                cellFactory.makeDetailInfoShimmer(for: indexPath)
            case .detailInfo(let props):
                cellFactory.makeDetailInfoCell(for: indexPath, with: props)
            case .settings(let props):
                cellFactory.makeSettingstCell(for: indexPath, with: props)
            }
        }
    }
}
