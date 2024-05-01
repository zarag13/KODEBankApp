import UI
import UIKit
import AppIndependent

final class MainController: TemplateViewController<MainView>, NavigationBarAlwaysVisible {

    typealias ViewModel = MainViewModel

    enum Event {
        case detailCard(DetailCardModel)
        case detailAccount(ConfigurationDetailAccountModel)
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
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Main.main
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .shimmer(let props):
                self?.rootView.configured(with: props)
            case .content(let props):
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.changeTabBar(hidden: false, animated: true)
                self?.stopErrorAnimation()
                self?.removeAdditionalState()
                self?.rootView.buttonIsHidden(false)
                self?.rootView.configured(with: props)
            case .openHiddenContent(let new, let section):
                self?.rootView.addNewItems(nweItems: new, into: section)
            case .closeHiddenContent(let items):
                self?.rootView.closeNewItems(nweItems: items)
            case .openCard(let model):
                self?.openDetailController?(.detailCard(model))
            case .openDetailAccount(let model):
                self?.openDetailController?(.detailAccount(model))
            case .noInternet(let alert):
                self?.stopErrorAnimation()
                self?.present(alert, animated: true)
            case .errorViewClosed:
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.changeTabBar(hidden: false, animated: true)
            case .error(let error):
                if self?.tabBarController?.selectedIndex == 0 {
                    self?.navigationController?.setNavigationBarHidden(true, animated: false)
                    self?.changeTabBar(hidden: true, animated: false)
                    self?.stopErrorAnimation()
                    self?.setAdditionState(.error(error))
                }
                self?.rootView.stopRefresh()
            }
        }

        rootView.onRefresh = { [weak self] in
            self?.viewModel.handle(.resfresh)
        }

        rootView.onNewProduct = {
            SnackCenter.shared.showSnack(withProps: .init(message: Main.newProducts, style: .basic))
        }
    }
}
