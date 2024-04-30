//
//  ProfileCellFactory.swift
//  AnyApp
//
//  Created by Kirill on 29.04.2024.
//

import UIKit
import UI

final class ProfileCellFactory {

    // MARK: - Private Properties
    private let tableView: BaseTableView

    // MARK: - Initializers
    init(tableView: BaseTableView) {
        self.tableView = tableView
    }

    func makeDetailInfoShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: ShimmerDetailInfoView.self,
            for: indexPath
        )
    }
    func makeSettingsShimmer(for indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: SettingShimerView.self,
            for: indexPath
        )
    }

    func makeDetailInfoCell(
        for indexPath: IndexPath,
        with props: DetailInfoView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: DetailInfoView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
    func makeSettingstCell(
        for indexPath: IndexPath,
        with props: SettingView.Props
    ) -> UITableViewCell {
        tableView.dequeueTemplateCell(
            forView: SettingView.self,
            for: indexPath
        ) { view, _ in
            view.configure(with: props)
        }
    }
}
