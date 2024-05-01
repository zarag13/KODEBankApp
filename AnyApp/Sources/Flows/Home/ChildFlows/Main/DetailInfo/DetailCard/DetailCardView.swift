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

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
        .hidingScrollIndicators()
    private lazy var dataSource = DetailAccountDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
    }

    private func body() -> UIView {
        VStack(alignment: .fill, distribution: .fill) {
            tableView
        }
    }
}

extension DetailCardView: ConfigurableView {
    typealias Model = DetailAccountViewProps

    func configure(with model: Model) {
        dataSource.apply(sections: model.sections)
    }

    func addNewItems(with items: Model.Section) {
        dataSource.applyNewItem(items: items)
    }
}
