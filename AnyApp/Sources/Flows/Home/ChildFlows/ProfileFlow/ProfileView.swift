import UI
import UIKit
import AppIndependent
import Combine

final class ProfileView: BackgroundPrimary {

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
        .hidingScrollIndicators()
    private let refreshControl = RefreshControll(contentStyle: .contentAccentTertiary)
    private lazy var dataSource = ProfileDataSource(tableView: tableView)

    public var onRefresh: VoidHandler?

    override func setup() {
        super.setup()
        body().embed(in: self)
        tableView.alwaysBounceVertical = false
        tableView.refreshControl = refreshControl
        setupBindings()
    }

    private func setupBindings() {
        self.refreshControl.onAction = { [weak self] in
            self?.onRefresh?()
        }
    }

    private func body() -> UIView {
        tableView
    }
}

extension ProfileView: ConfigurableView {
    typealias Model = ProfileViewProps

    public func configure(with model: Model) {
        dataSource.apply(sections: model.sections)
        self.refreshControl.endRefreshing()
    }

    public func configureSettings(with section: Model.Section) {
        dataSource.applySettingSection(section: section)
        self.refreshControl.endRefreshing()
    }
}
