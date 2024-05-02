//
//  DetailCardView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DetailCardView: BackgroundPrimary {

    private let tableView = BaseTableView()
        .hidingScrollIndicators()
    private lazy var dataSource = DetailAccountDataSource(tableView: tableView)
    private let refreshControl = RefreshControll(contentStyle: .contentAccentTertiary)

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
        VStack(alignment: .fill, distribution: .fill) {
            tableView
        }
    }

    public func stopRefresh() {
        refreshControl.endRefreshing()
    }
}

extension DetailCardView: ConfigurableView {
    typealias Model = DetailAccountViewProps

    func configure(with model: Model) {
        dataSource.apply(sections: model.sections)
        refreshControl.endRefreshing()
    }

    func addNewItems(with items: Model.Section) {
        dataSource.applyNewItem(items: items)
    }
}
