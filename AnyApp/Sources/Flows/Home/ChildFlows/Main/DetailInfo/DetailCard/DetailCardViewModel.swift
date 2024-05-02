//
//  DetailCardViewModel.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import Services
import Combine
import UI
import UIKit

final class DetailCardViewModel: NetworkErrorHandler {

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
    private let cardModel: DetailCardModel
    private let coreRequestManager: CoreManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    init(cardModel: DetailCardModel, coreRequestManager: CoreManagerAbstract) {
        self.cardModel = cardModel
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
            .spacer(.init(height: 16, style: .backgroundSecondary)),
            .header(.init(title: Main.payments)),
            .favorites(.init(id: "1", title: Main.Card.mobileCommunication, leftImage: Asset.Icon24px.mobile.image)),
            .favorites(.init(id: "2", title: Main.Card.hcs, leftImage: Asset.Icon24px.jkh.image)),
            .favorites(.init(id: "3", title: Main.Card.internet, leftImage: Asset.Icon24px.internet.image))
        ])

    lazy var historyData: Props.Section =
        .history([
            .spacer(.init(height: 16, style: .backgroundSecondary)),
            .header(.init(title: "Июнь 2021")),
            .history(.init(id: "1", title: "25 июня, 18:52", description: "Оплата ООО «ЯнтарьЭнерго»", leftImage: Asset.Icon40px.yantar.image, money: "-1 500,00 ₽")),
            .history(.init(id: "2", title: "25 июня, 17:52", description: "Зачисление зарплаты", leftImage: Asset.Icon24px.cardPay.image, money: "+15 000,00 ₽")),
            .history(.init(id: "3", title: "25 июня, 16:52", description: "Перевод Александру Олеговичу С.", leftImage: Asset.Icon24px.accountPay.image, money: "6 000,00 ₽"))
        ])

    lazy var settingsData: Props.Section =
        .history([
            .spacer(.init(height: 16, style: .backgroundSecondary)),
            .settings(.init(id: "1", title: Main.Card.renameCard, leftImage: Asset.Icon24px.rename.image, rightImage: false)),
            .settings(.init(id: "2", title: Main.Card.accountDetails, leftImage: Asset.Icon24px.requisites.image, rightImage: false)),
            .settings(.init(id: "3", title: Main.Card.informationAboutCard, leftImage: Asset.Icon24px.card.image, rightImage: false)),
            .settings(.init(id: "4", title: Main.Card.reissueCard, leftImage: Asset.Icon24px.cardOut.image, rightImage: false)),
            .settings(.init(id: "5", title: Main.Card.blockCard, leftImage: Asset.Icon24px.lock.image, rightImage: false))
        ])

    lazy var actionData: Props.Item = .actions(.init(id: "2", onTap: { [weak self] state in
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

    private func loadData() {
        coreRequestManager.detailCard(cardModel.codeId).sink { [weak self] error in
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
            guard let actionView = self?.actionData else { return }
            guard let history = self?.reloadHistory() else { return }
            self?.onOutput?(.content(.init(sections: [
                .detailHeader([
                    .card(.init(networkProps: response, title: self?.cardModel.nameCard ?? "", sumMoney: "457 334,00 ₽", styleCard: Asset.BigBankCard.debit.image)),
                    actionView
                ]),
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
