import Services
import Combine
import UI

final class MainViewModel {

    typealias Props = MainViewProps

    enum Output {
        case content(Props)
        case openHiddenContent([Props.Item], Props.Item)
        case closeHiddenContent([Props.Item])
        case open
        case openCard
    }

    enum Input {
        case loadData
    }

    var onOutput: ((Output) -> Void)?

    func handle(_ input: Input) {
        switch input {
        case .loadData:
            loadData()
        }
    }

    lazy var openItem: [Props.Item] = [
        .card(.init(id: "2", title: "Карта зарплатная", description: "Физическая", rightImage: .init(cardNumber: "7789", backgroundCardImage: Asset.MiniBankCard.bankCard.image, iconBankImage: Asset.SmallIcon.masterCard.image), leftImage: Asset.Icon24px.input.image, state: .availabil,  onTap: { _ in
            self.onOutput?(.openCard)
        })),
        .card(.init(id: "3", title: "Дополнительная карта", description: "Заблокирована", rightImage: .init(cardNumber: "8435", backgroundCardImage: Asset.MiniBankCard.bankCardDisable.image, iconBankImage: Asset.SmallIcon.visa.image), leftImage: Asset.Icon24px.input.image, state: .unavailabil))
    ]

    private func loadData() {
        onOutput?(.content(.init(sections: [
            .accounts(
                [.spacer(.init(height: 16))] +
                [.shimmerHeader()] +
                (1...3).map { _ in .shimmerCell() }
                ),
            .deposits(
                [.spacer(.init(height: 16))] +
                [.shimmerHeader()] +
                (1...3).map { _ in .shimmerCell() }
            )
        ])))

        // request:

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onOutput?(.content(.init(sections: [
                .accounts([
                    .header(.init(title: "Счета")),
                    .account(.init(id: "1", title: "Счет расчетный", description: "457 334,00 ₽", leftImage: Asset.Icon40px.rub.image, onTap: { value, state  in
                        if value.id == "1" {
                            switch state {
                            case .open:
                                self?.onOutput?(.openHiddenContent(
                                    self?.openItem ?? [],
                                    .account(value)
                                ))
                            case .close:
                                self?.onOutput?(.closeHiddenContent(
                                    self?.openItem ?? []))
                            }
                        }
                    }, openTap: {
                        self?.onOutput?(.open)
                    }))
                ] +
                          (self?.openItem ?? [])
                ),
                .deposits([
                    .spacer(.init(height: 16)),
                    .header(.init(title: "Вклады")),
                    .error(.init(id: "1", title: "", description: "", titleButton: ""))
//                    .deposit(.init(id: "1", title: "Мой вклад", description: "1 515 000,78 ₽", rightImage: Asset.Icon40px.rub.image, percentStake: "Ставка 7.65%", date: "до 31.08.2024")),
//                    .deposit(.init(id: "2", title: "Накопительный", description: "3 719,19 $", rightImage: Asset.Icon40px.icUsd.image, percentStake: "Ставка 11.05%", date: "до 31.08.2024")),
//                    .deposit(.init(id: "3", title: "EUR вклад", description: "1 513,62 €", rightImage: Asset.Icon40px.icEur.image, percentStake: "Ставка 8.65%", date: "до 31.08.2026"))
                ])
            ])))
        }
    }
}
