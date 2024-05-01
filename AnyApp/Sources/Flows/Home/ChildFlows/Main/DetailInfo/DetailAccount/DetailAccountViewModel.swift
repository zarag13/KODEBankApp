//
//  DetailAccountViewModel.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import Services
import Combine
import UI

final class DetailAccountViewModel {

    typealias Props = DetailAccountViewProps

    enum Output {
        case content(Props)
        case addNewItems(Props.Section)
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?
    
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
            .header(.init(title: "Платежи")),
            .favorites(.init(id: "1", title: "Мобильная связь", leftImage: Asset.Icon24px.mobile.image)),
            .favorites(.init(id: "2", title: "ЖКХ", leftImage: Asset.Icon24px.jkh.image)),
            .favorites(.init(id: "3", title: "Интернет", leftImage: Asset.Icon24px.internet.image)),
        ])

    lazy var historyData: Props.Section =
        .history([
            .header(.init(title: "Июнь 2021")),
            .history(.init(id: "1", title: "25 июня, 18:52", description: "Оплата ООО «ЯнтарьЭнерго»", leftImage: Asset.Icon40px.yantar.image, money: "-1 500,00 ₽")),
            .history(.init(id: "2", title: "25 июня, 17:52", description: "Зачисление зарплаты", leftImage: Asset.Icon24px.cardPay.image, money: "+15 000,00 ₽")),
            .history(.init(id: "3", title: "25 июня, 16:52", description: "Перевод Александру Олеговичу С.", leftImage: Asset.Icon24px.accountPay.image, money: "6 000,00 ₽")),
        ])

    lazy var settingsData: Props.Section =
        .history([
            .settings(.init(id: "1", title: "Переименовать карту", leftImage: Asset.Icon24px.rename.image, rightImage: false)),
            .settings(.init(id: "2", title: "Реквизиты счета", leftImage: Asset.Icon24px.requisites.image, rightImage: false)),
            .settings(.init(id: "3", title: "Информация о карте", leftImage: Asset.Icon24px.card.image, rightImage: false)),
            .settings(.init(id: "4", title: "Перевыпустить карту", leftImage: Asset.Icon24px.cardOut.image, rightImage: false)),
            .settings(.init(id: "5", title: "Заблокировать карту", leftImage: Asset.Icon24px.lock.image, rightImage: false)),
        ])
    
    lazy var headCartData: [Props.Item] = [
        .account(.init(id: "1", title: "Счет расчетный", topImage: Asset.Icon40px.rub.image, cardNumber: "**** **** **** **** 5666", moneyCurrent: "457 334,00 ₽"))
    ]

    lazy var actionData: [Props.Item] = [
        .actions(.init(id: "2", onTap: { state in
            switch state {
            case .history:
                self.onOutput?(.addNewItems(self.historyData))
            case .settings:
                self.onOutput?(.addNewItems(self.settingsData))
            case .favorites:
                self.onOutput?(.addNewItems(self.favoritesData))
            }
        }))
    ]

    private func loadData() {
        print(configurationModel.accountId)
        onOutput?(.content(.init(sections: [
            .detailHeader(headCartData + actionData),
            historyData
        ])))
    }
    
//    var favoritesData: Props = .init(sections: [
//        //.detailHeader([]),
//        //.history([]),
//        //.settings([]),
//        .history([
//            .header(.init(title: "Платежи")),
//            .favorites(.init(id: "1", title: "Мобильная связь", leftImage: Asset.Icon24px.mobile.image)),
//            .favorites(.init(id: "2", title: "ЖКХ", leftImage: Asset.Icon24px.jkh.image)),
//            .favorites(.init(id: "3", title: "Интернет", leftImage: Asset.Icon24px.internet.image)),
//            
//        ])
//        
//    ])
//
//    private func loadData() {
//        onOutput?(.content(.init(sections: [
//            .history([
//                .header(.init(title: "Июнь 2021")),
//                .history(.init(id: "1", title: "25 июня, 18:52", description: "Оплата ООО «ЯнтарьЭнерго»", leftImage: Asset.Icon40px.yantar.image, money: "-1 500,00 ₽")),
//                .history(.init(id: "2", title: "25 июня, 17:52", description: "Зачисление зарплаты", leftImage: Asset.Icon24px.cardPay.image, money: "+15 000,00 ₽")),
//                .history(.init(id: "3", title: "25 июня, 16:52", description: "Перевод Александру Олеговичу С.", leftImage: Asset.Icon24px.accountPay.image, money: "-6 000,00 ₽")),
//            ])
//        
//        ])))
//    }
}

