//
//  DetailAccountCellFactory.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UIKit
import UI

final class DetailAccountCellFactory {

    // MARK: - Private Properties

    private let tableView: BaseTableView

    // MARK: - Initializers

    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    // MARK: - Common

    func makeShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: TemplateShimmerView.self,
            for: indexPath
        )
    }

    // MARK: - Cells
    func makeHistoryAccountCell(
        for indexPath: IndexPath,
        with props: HistoryAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HistoryAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeSettingsAccountCell(
        for indexPath: IndexPath,
        with props: SettingsAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: SettingsAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    
    func makeFavoritesAccountCell(
        for indexPath: IndexPath,
        with props: FavoritesAccountView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: FavoritesAccountView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeTemplateHeaderCell(
        for indexPath: IndexPath,
        with props: HeaderDetailInfoCell.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: HeaderDetailInfoCell.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeSpacerSections(
        for indexPath: IndexPath,
        with props: BaseTableSpacer.Props
    ) -> UITableViewCell {
        tableView.dequeueSpacer(props, for: indexPath)
            .backgroundColor(BackgroundStyle.backgroundPrimary.color)
    }

    func makeDetailCardHeaderView(
        for indexPath: IndexPath,
        with props: DetailCardHeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DetailCardHeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeActionsTabsView(
        for indexPath: IndexPath,
        with props: ActionsTabsView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ActionsTabsView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }

    func makeDetailAccountHeaderView(
        for indexPath: IndexPath,
        with props: DetailAccountHeaderView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DetailAccountHeaderView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}
