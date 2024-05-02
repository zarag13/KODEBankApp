import Services
import UIKit
import Combine
import UI

final class MainViewModel: NetworkErrorHandler {

    typealias Props = MainViewProps

    enum Output {
        case shimmer(Props)
        case content(Props)
        case openHiddenContent([Props.Item], Props.Item)
        case closeHiddenContent([Props.Item])
        case openCard(DetailCardModel)
        case openDetailAccount(ConfigurationDetailAccountModel)
        case noInternet(UIAlertController)
        case errorViewClosed
        case error(ErrorView.Props)
    }

    enum Input {
        case loadData
        case resfresh
    }

    private var arrayCards = [TemplateCardView.Props]()
    private let coreRequestManager: CoreManagerAbstract
    private var cancellables = Set<AnyCancellable>()

    public var onOutput: ((Output) -> Void)?

    init(authRequestManager: CoreManagerAbstract) {
        self.coreRequestManager = authRequestManager
    }

    private func lodIsStart() {
        self.onOutput?(.shimmer(.init(sections: [
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
    }

    private func loadData() {
        self.coreRequestManager.accountListData().combineLatest(self.coreRequestManager.depositListData()).sink { [weak self] error in
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

    private func depositeViewProps(_ response: Deposit) -> MainViewProps.Item {
        MainViewProps.Item.deposit(.init(networkProps: response, percentStake: "Ставка 7.65%", date: "до 31.08.2024", onTap: { _ in
        }))
    }

    private func depositsViewProps(_ response: DepositListReponse) -> [MainViewProps.Item] {
        [.spacer(.init(height: 16, style: .backgroundPrimary))] +
        [.header(.init(title: Main.deposits))] +
        response.deposits.map({ deposit in
            self.depositeViewProps(deposit)
        })
    }

    private func accountsViewProps(_ response: AccountListResponse) -> [MainViewProps.Item] {
        [.header(.init(title: Main.accounts))] +
        response.accounts.flatMap({ account in
            self.accountViewProps(account)
        })
    }

    private func accountViewProps(_ response: Account) -> [MainViewProps.Item] {
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
            let props = TemplateCardView.Props(networkProps: card, accountId: response.accountID, cardNumber: response.number) { id, title in
                let model = DetailCardModel(codeId: id, nameCard: title)
                self.onOutput?(.openCard(model))
            }
            if !arrayCards.contains(props) {
                arrayCards.append(props)
            }
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

    public func handle(_ input: Input) {
        switch input {
        case .loadData:
            lodIsStart()
            loadData()
        case .resfresh:
            loadData()
        }
    }
}
