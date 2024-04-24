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
        navigationController?.navigationBar.isHidden = true
        setupBindings()
        rootView.state?(.isBeingDownloadData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.rootView.state?(.hasBeenDownloadData)
        }
    }

    private func setupBindings() {
        rootView.event = { [weak self] event in
            switch event {
            case .onLogout:
                break
            case .onThemeApp:
                self?.openSettingsController?(.themeApp)
            case .onAboutApp:
                self?.openSettingsController?(.aboutApp)
            case .supportService:
                self?.viewModel.handle(.supportService)
            case .exit:
                self?.viewModel.handle(.logout)
            }
        }
    }
}
