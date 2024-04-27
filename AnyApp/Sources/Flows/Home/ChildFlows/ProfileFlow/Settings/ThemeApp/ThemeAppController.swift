//
//  ThemeAppController.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit

final class ThemeAppController: TemplateViewController<ThemeAppView> {

    typealias ViewModel = ThemeAppViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        configureNavigationItem()
    }

    private func configureNavigationItem() {
        rootView.navigationBar
            .popController(navigation: self.navigationController)
    }

    func setupBindings() {
        self.rootView.themeAppStackView.onEvent = { [weak self] theme in
            self?.viewModel.handle(.themeApp(theme))
        }
    }
}
