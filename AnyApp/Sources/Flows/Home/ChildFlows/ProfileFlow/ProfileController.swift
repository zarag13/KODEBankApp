import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel

    enum Event {
        case themeApp
        case aboutApp
    }
    var openSettingsController: ((Event) -> Void)?

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
        viewModel.handle(.loadView)
    }

    private func configureNavigationItem() {
        navigationController?.navigationBar.isHidden = true
    }

    private func setupBindings() {
        rootView.event = { [weak self] event in
            switch event {
            case .aboutApp:
                self?.openSettingsController?(.aboutApp)
            case .themeApp:
                self?.openSettingsController?(.themeApp)
            case .supportService:
                self?.viewModel.handle(.supportService)
            case .exit:
                self?.createLogautAlertController()
            }
        }

        viewModel?.onOutput = { event in
            switch event {
            case .detailProfileData(let props):
                self.rootView.handle(.hasBeenDownloadData(props))
            }
        }
    }

    private func createLogautAlertController() {
        let alert = UIAlertController(title: "Вы точно хотите выйти?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            alert.dismiss(animated: true)
        }
        let doneAction = UIAlertAction(title: "Выйти", style: .default) { _ in
            self.viewModel.handle(.logout)
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}
