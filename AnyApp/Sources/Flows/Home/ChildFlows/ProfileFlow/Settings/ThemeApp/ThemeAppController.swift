//
//  ThemeAppController.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit
import AppIndependent

final class ThemeAppController: TemplateViewController<ThemeAppView>, NavigationBarAlwaysVisible {

    typealias ViewModel = ThemeAppViewModel

    // MARK: - Private Properties
    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        configureNavigationItem()
        setupBindings()
        viewModel?.handle(.loadView)
    }

    private func configureNavigationItem() {
        navigationItem.title = Profile.themeApp
    }

    private func setupBindings() {
        viewModel.onEvent = { [weak self] event in
            switch event {
            case .themeCells(let props):
                self?.rootView.configure(with: props)
            }
        }
    }
}
