//
//  AboutAppController.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit
import AppIndependent

final class AboutAppController: TemplateViewController<AboutAppView>, NavigationBarAlwaysVisible {
    typealias ViewModel = AboutAppViewModel

    // MARK: - Private Properties
    private var viewModel: ViewModel!

    // MARK: - Private Methods
    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        configureNavigationItem()
        setupBindings()
    }

    private func configureNavigationItem() {
        navigationItem.title = Profile.aboutApp
    }

    private func setupBindings() {
        viewModel.event = { [weak self] event in
            switch event {
            case .varsion(let version):
                self?.rootView.configure(version: version)
            }
        }
        viewModel.handler(.getVersion)
    }
}
