//
//  DetailAccountView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DetailAccountView: BackgroundPrimary {

    private let tableView = BaseTableView()
        .hidingScrollIndicators()
    private let refreshControl = RefreshControll(contentStyle: .contentAccentTertiary)
    private lazy var dataSource = DetailAccountDataSource(tableView: tableView)

    public var onRefresh: VoidHandler?

    override func setup() {
        super.setup()
        tableView.alwaysBounceVertical = false
        tableView.refreshControl = refreshControl
        setupBindings()
        body().embed(in: self)
    }

    private func setupBindings() {
        self.refreshControl.onAction = { [weak self] in
            self?.onRefresh?()
        }
    }

    private func body() -> UIView {
        tableView
    }

    public func stopRefresh() {
        refreshControl.endRefreshing()
    }
}

extension DetailAccountView: ConfigurableView {
    typealias Model = DetailAccountViewProps

    func configure(with model: Model) {
        dataSource.apply(sections: model.sections)
        refreshControl.endRefreshing()
    }

    func addNewItems(with items: Model.Section) {
        dataSource.applyNewItem(items: items)
    }
}
