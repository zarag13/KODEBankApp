import UI
import UIKit
import AppIndependent

final class MainView: BackgroundPrimary {

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
        .hidingScrollIndicators()
    private let button = ButtonPrimary(title: "Открыть новый счет или продукт")
    private lazy var dataSource = MainDataSource(tableView: tableView)
    private let refreshControl = RefreshControll(contentStyle: .contentAccentTertiary)

    public var onRefresh: VoidHandler?

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupButton()
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

    private func setupButton() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(24)
        }
        button.onTap { [weak self] in
            self?.onNewProduct?()
        }
        button.isHidden = true
    }

    public func stopRefresh() {
        self.refreshControl.endRefreshing()
    }

    public func buttonIsHidden(_ isHidden: Bool) {
        button.isHidden = isHidden
    }
}

extension MainView: ConfigurableView {
    typealias Model = MainViewProps

    func configure(with model: MainViewProps) {
        dataSource.apply(sections: model.sections)
        stopRefresh()
    }
    func addNewItems(nweItems: [MainViewProps.Item], into section: MainViewProps.Item) {
        dataSource.applyNewItemInSection(nweItems: nweItems, into: section)
    }
    func closeNewItems(nweItems: [MainViewProps.Item]) {
        dataSource.closeNewItemInSection(nweItems: nweItems)
    }
}
