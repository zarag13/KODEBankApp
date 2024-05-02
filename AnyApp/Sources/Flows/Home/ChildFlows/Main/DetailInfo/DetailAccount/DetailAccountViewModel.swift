//
//  DetailAccountViewModel.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import Services
import Combine
import UI
import UIKit

final class DetailAccountViewModel: NetworkErrorHandler {

    typealias Props = DetailAccountViewProps

    enum Output {
        case content(Props)
        case addNewItems(Props.Section)
        case noInternet(UIAlertController)
        case errorViewClosed
        case error(ErrorView.Props)
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?
    private var state: ActionsTabsView.State = .history
    private let configurationModel: ConfigurationDetailAccountModel
    private let coreRequestManager: CoreManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    init(configurationModel: ConfigurationDetailAccountModel, coreRequestManager: CoreManagerAbstract) {
        self.configurationModel = configurationModel
        self.coreRequestManager = coreRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    lazy var favoritesData: Props.Section =
        .history([
            .spacer(.init(height: 16, style: .backgroundPrimary)),
            .favorites(.init(id: "1", title:  Main.Account.mobileCommunication, leftImage: Asset.Icon24px.mobile.image)),
            .favorites(.init(id: "2", title:  Main.Account.hcs, leftImage: Asset.Icon24px.jkh.image)),
            .favorites(.init(id: "3", title:  Main.Account.internet, leftImage: Asset.Icon24px.internet.image))
        ])

    lazy var historyData: Props.Section =
        .history([
            .spacer(.init(height: 16, style: .backgroundPrimary)),
            .header(.init(title: "Июнь 2021")),
            .history(.init(id: "1", title: "25 июня, 18:52", description: "Оплата ООО «ЯнтарьЭнерго»", leftImage: Asset.Icon40px.yantar.image, money: "-1 500,00 ₽")),
            .history(.init(id: "2", title: "25 июня, 17:52", description: "Зачисление зарплаты", leftImage: Asset.Icon24px.cardPay.image, money: "+15 000,00 ₽")),
            .history(.init(id: "3", title: "25 июня, 16:52", description: "Перевод Александру Олеговичу С.", leftImage: Asset.Icon24px.accountPay.image, money: "6 000,00 ₽"))
        ])

    lazy var settingsData: Props.Section =
        .history([
            .spacer(.init(height: 16, style: .backgroundPrimary)),
            .settings(.init(id: "1", title: Main.Account.linkedCards, leftImage: Asset.Icon24px.cardWhite.image, rightImage: true)),
            .settings(.init(id: "2", title: Main.Account.renameAccount, leftImage: Asset.Icon24px.rename.image, rightImage: false)),
            .settings(.init(id: "3", title: Main.Account.details, leftImage: Asset.Icon24px.requisites.image, rightImage: false)),
            .settings(.init(id: "4", title: Main.Account.close, leftImage: Asset.Icon24px.bankAccount.image, rightImage: false))
        ])

    lazy var actionData: [Props.Item] = [
        .actions(.init(id: "2", onTap: { [weak self] state in
            self?.state = state
            switch state {
            case .history:
                guard let history = self?.historyData else { return }
                self?.onOutput?(.addNewItems(history))
            case .settings:
                guard let settings = self?.settingsData else { return }
                self?.onOutput?(.addNewItems(settings))
            case .favorites:
                guard let favorites = self?.favoritesData else { return }
                self?.onOutput?(.addNewItems(favorites))
            }
        }))
    ]

    private func loadData() {
        coreRequestManager.detailAccount(configurationModel.accountId).sink { [weak self] error in
            guard case let .failure(error) = error else { return }
            guard let errorProps = self?.errorHandle(
                error,
                onTap: {
                if error.appError.kind == .timeout {
                    self?.checkInternet(returnAlert: { alert in
                        self?.onOutput?(.noInternet(alert))
                    }, returnIsOn: {
                        self?.loadData()
                    })
                } else {
                    self?.loadData()
                }
            },
                closeTap: {
                self?.onOutput?(.errorViewClosed)
            }) else { return }
            self?.onOutput?(.error(errorProps))
        } receiveValue: { [weak self] response in
            guard let history = self?.reloadHistory() else { return }
            self?.onOutput?(.content(.init(sections: [
                .detailHeader([
                    .account(.init(networkProps: response, title: Main.detailAccount))
                ] + (self?.actionData ?? [])),
                history
            ])))
        }.store(in: &cancellables)
    }

    private func reloadHistory() -> Props.Section {
        switch state {
        case .history:
            return self.historyData
        case .settings:
            return self.settingsData
        case .favorites:
            return self.favoritesData
        }
    }
}
