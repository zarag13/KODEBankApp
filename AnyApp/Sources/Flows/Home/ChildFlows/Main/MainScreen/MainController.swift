import UI
import UIKit

final class MainController: TemplateViewController<MainView> {

    typealias ViewModel = MainViewModel
    
    enum Event {
        case detailCard
        case detailAccount
    }
    var openDetailController: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadData)
    }

    private func configureNavigationItem() {
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = "Главная"
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            case .openHiddenContent(let new, let section):
                self?.rootView.addNewItems(nweItems: new, into: section)
            case .closeHiddenContent(let items):
                self?.rootView.closeNewItems(nweItems: items)
            case .open:
                self?.openDetailController?(.detailAccount)
//                let model = DetailAccountViewModel()
//                let vc = DetailAccountController(viewModel: model)
//                self?.present(vc, animated: true)
            case .openCard:
                self?.openDetailController?(.detailCard)
//                let model = DetailCardViewModel()
//                let vc = DetailCardController(viewModel: model)
//                self?.present(vc, animated: true)
            }
        }

        rootView.onNewProduct = { [weak self] in
            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
        }
    }
}
