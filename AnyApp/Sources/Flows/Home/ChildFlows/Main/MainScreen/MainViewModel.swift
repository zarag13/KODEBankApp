import Services
import UIKit
import Combine
import UI

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
        case openHiddenContent([Props.Item], Props.Item)
        case closeHiddenContent([Props.Item])
        case openCard(DetailCardModel)
        case openDetailAccount(ConfigurationDetailAccountModel)
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

    private let coreRequestManager: CoreManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    init(authRequestManager: CoreManagerAbstract) {
        self.coreRequestManager = authRequestManager
    }

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    private func loadData() {
        self.onOutput?(.content(.init(sections: [
            .accounts(
                [.spacer(.init(height: 16, style: nil))] +
                [.shimmerHeader()] +
                (1...3).map { _ in .shimmerCell() }
            ),
            .deposits(
                [.spacer(.init(height: 16, style: nil))] +
                [.shimmerHeader()] +
                (1...3).map { _ in .shimmerCell() }
            )
        ])))

        self.coreRequestManager.accountListData().combineLatest(self.coreRequestManager.depositListData()).sink { _ in
            // error
        } receiveValue: { [weak self] accounts, deposits in
            self?.onOutput?(.content(.init(sections: [
                .accounts(
                    (self?.accountsViewProps(accounts) ?? [])
                ),
                .deposits(
                    (self?.depositsViewProps(deposits) ?? [])
                )
            ])))
        }
        .store(in: &cancellables)
    }

    func depositeViewProps(_ response: Deposit) -> MainViewProps.Item {
        MainViewProps.Item.deposit(.init(networkProps: response, percentStake: "Ставка 7.65%", date: "до 31.08.2024", onTap: { _ in
        }))
    }

    var arrayCards = [TemplateCardView.Props]()

    func depositsViewProps(_ response: DepositListReponse) -> [MainViewProps.Item] {
        [.spacer(.init(height: 16, style: .backgroundPrimary))] +
        [.header(.init(title: "Вклады"))] +
        response.deposits.map({ deposit in
            self.depositeViewProps(deposit)
        })
    }

    func accountsViewProps(_ response: AccountListResponse) -> [MainViewProps.Item] {
        [.header(.init(title: "Счета"))] +
        response.accounts.flatMap({ account in
            self.accountViewProps(account)
        })
    }

    func accountViewProps(_ response: Account) -> [MainViewProps.Item] {
        let account = [
            MainViewProps.Item.account(.init(
                title: "Счет расчетный",
                networkProps: response,
                onTap: { props, state in
            let cards = self.createAndSearchCardForAccount(props, self.arrayCards)
            switch state {
            case .open:
                self.onOutput?(.openHiddenContent(cards, .account(props)))
            case .close:
                self.onOutput?(.closeHiddenContent(cards))
            }
        }, openTap: { [weak self] id in
            let config = ConfigurationDetailAccountModel(accountId: id)
            self?.onOutput?(.openDetailAccount(config))
        }))
        ]
        let cards = response.cards.map { card in
            let props = TemplateCardView.Props(networkProps: card, accountId: response.accountID, cardNumber: response.number) { id in
                let model = DetailCardModel(codeId: id)
                self.onOutput?(.openCard(model))
            }
            arrayCards.append(props)
            return MainViewProps.Item.card(props)
        }

        return account + cards
    }

    private func createAndSearchCardForAccount(
        _ props: TemplateAccountView.Props,
        _ cards: [TemplateCardView.Props]) -> [Props.Item] {
        return cards.filter { card in
            card.accountId == props.id
        }.map { card in
            Props.Item.card(card)
        }
    }
}
