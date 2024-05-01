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
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
                self?.rootView.configured(with: props)
                self?.stopErrorAnimation()
                self?.removeAdditionalState()
            case .addNewItems(let props):
                self?.rootView.addNewItems(with: props)
            case .noInternet(let alert):
                self?.stopErrorAnimation()
                self?.present(alert, animated: true)
            case .errorViewClosed:
                self?.navigationController?.setNavigationBarHidden(false, animated: false)
            case .error(let error):
                self?.navigationController?.setNavigationBarHidden(true, animated: false)
                self?.stopErrorAnimation()
                self?.setAdditionState(.error(error))
                self?.rootView.stopRefresh()
            }
        }

        rootView.onRefresh = { [weak self] in
            self?.viewModel.handle(.loadData)
        }
    }
}
