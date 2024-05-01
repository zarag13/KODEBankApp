//
//  DetailAccountController.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent

final class DetailAccountController: TemplateViewController<DetailAccountView>, NavigationBarAlwaysVisible {

    typealias ViewModel = DetailAccountViewModel

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
        navigationItem.title = "Счета"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationItem()
    }
    

    private func setupBindings() {
        viewModel.onOutput = { [weak self] output in
            switch output {
            case .content(let props):
                self?.rootView.configured(with: props)
            case .addNewItems(let props):
                self?.rootView.addNewItems(with: props)
            }
        }
        rootView.onNewProduct = { [weak self] in
            SnackCenter.shared.showSnack(withProps: .init(message: "!New Product"))
        }
    }
}
