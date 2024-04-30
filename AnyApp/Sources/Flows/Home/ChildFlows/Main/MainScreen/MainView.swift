import UI
import UIKit
import AppIndependent

final class MainView: BackgroundPrimary {

    var onNewProduct: VoidHandler?

    private let tableView = BaseTableView()
    //private let button = ButtonPrimary(title: "Открыть новый счет или продукт")
    let button = ButtonPrimary(title: "Открыть новый счет или продукт")
    private lazy var dataSource = MainDataSource(tableView: tableView)

    override func setup() {
        super.setup()
        body().embed(in: self)
        setupButton()
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
//        button.onTap { [weak self] in
//            self?.onNewProduct?()
//        }
    }
}

extension MainView: ConfigurableView {
    typealias Model = MainViewProps

    func configure(with model: MainViewProps) {
        dataSource.apply(sections: model.sections)
    }
    func addNewItems(nweItems: [MainViewProps.Item], into section: MainViewProps.Item) {
        dataSource.applyNewItemInSection(nweItems: nweItems, into: section)
    }
    func closeNewItems(nweItems: [MainViewProps.Item]) {
        dataSource.closeNewItemInSection(nweItems: nweItems)
    }
}
