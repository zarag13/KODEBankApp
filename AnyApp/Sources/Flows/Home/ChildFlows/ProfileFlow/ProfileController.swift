import UI
import UIKit
import AppIndependent

final class ProfileController: TemplateViewController<ProfileView>, NavigationBarAlwaysHidden {
    typealias ViewModel = ProfileViewModel
    enum Event {
        case themeApp
        case aboutApp
    }

    // MARK: - Private Properties
    private var viewModel: ViewModel!

    // MARK: - Public Properties
    public var openSettingsController: ((Event) -> Void)?

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        setupBindings()
        viewModel.handle(.loadView)
    }
    private func setupBindings() {
        viewModel.onOutput = { [weak self] event in
            switch event {
            case .content(let props):
                self?.changeTabBar(hidden: false, animated: true)
                self?.stopErrorAnimation()
                self?.rootView.configured(with: props)
                self?.removeAdditionalState()
            case .error(let error, let section):
                if self?.tabBarController?.selectedIndex == 1 {
                    self?.changeTabBar(hidden: true, animated: false)
                    self?.stopErrorAnimation()
                    self?.setAdditionState(.error(error))
                }
                self?.rootView.configureSettings(with: section)
            case .noInternet(let alert):
                self?.stopErrorAnimation()
                self?.present(alert, animated: true)
            case .openSetiings(let event):
                switch event {
                case .aboutApp:
                    self?.openSettingsController?(.aboutApp)
                case .themeApp:
                    self?.openSettingsController?(.themeApp)
                case .exit:
                    self?.createLogautAlertController()
                default: break
                }
            case .errorViewClosed:
                self?.changeTabBar(hidden: false, animated: true)
            }
        }
        self.rootView.onRefresh = { [weak self] in
            self?.viewModel.handle(.resfresh)
        }
    }

    private func createLogautAlertController() {
        let alert = UIAlertController(title: "Вы точно хотите выйти?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { [weak alert] _ in
            alert?.dismiss(animated: true)
        }
        let doneAction = UIAlertAction(title: "Выйти", style: .default) { [weak self] _ in
            self?.viewModel.handle(.logout)
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}
