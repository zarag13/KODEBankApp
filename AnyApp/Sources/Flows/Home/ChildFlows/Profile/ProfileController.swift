import UI
import UIKit

final class ProfileController: TemplateViewController<ProfileView> {

    typealias ViewModel = ProfileViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        rootView.state?(.isBeingDownloadData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.rootView.state?(.hasBeenDownloadData)
        }
    }

    private func setupBindings() {
        rootView.onLogout = { [weak self] in
            self?.viewModel.handle(.logout)
        }
    }
}
