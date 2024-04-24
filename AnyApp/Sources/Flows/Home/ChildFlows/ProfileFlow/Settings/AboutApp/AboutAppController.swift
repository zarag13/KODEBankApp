//
//  AboutAppController.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import UI
import UIKit

final class AboutAppController: TemplateViewController<AboutAppView> {

    typealias ViewModel = AboutAppViewModel

    private var viewModel: ViewModel!

    convenience init(viewModel: ViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    override func setup() {
        super.setup()
        setupBindings()
        rootView.navigationBar
            .popController(navigation: self.navigationController)
    }

    func setupBindings() {
        viewModel.event = { [weak self] event in
            switch event {
            case .varsion(let version):
                self?.rootView.configure(version: version)
            }
        }
        viewModel.handler(.getVersion)
    }
}
