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

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
    private lazy var dataSource = DetailAccountDataSource(tableView: tableView)
    let navigationBar = MainNavigationBar()

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack(alignment: .fill, distribution: .fill) {
            BackgroundView(hPadding: 16) {
                navigationBar
                    .setuptile(title: "Cчета")
            }
            tableView
        }
    }
}

extension DetailAccountView: ConfigurableView {
    typealias Model = DetailAccountViewProps

    func configure(with model: Model) {
        dataSource.apply(sections: model.sections)
    }

    func addNewItems(with items: Model.Section) {
        dataSource.applyNewItem(items: items)
    }
}
