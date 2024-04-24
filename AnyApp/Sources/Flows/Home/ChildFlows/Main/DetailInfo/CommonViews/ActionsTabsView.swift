//
//  ActionsTabsView.swift
//  AnyApp
//
//  Created by Kirill on 20.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class ActionsTabsView: BackgroundPrimary {
    enum State: CaseIterable {
        case history
        case settings
        case favorites
    }

    private var cancellable = Set<AnyCancellable>()
    private var state = CurrentValueSubject<State, Never>(.history)

    private var props: Props?

    override func setup() {
        super.setup()
        body().embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
        state.sink { state in
            self.props?.onTap?(state)
        }.store(in: &cancellable)
    }
    private func body() -> UIView {
        ForEach(collection: State.allCases, alignment: .fill, distribution: .fillEqually, spacing: 40, axis: .horizontal) { state in
            self.createAction(event: state)
        }
        .layoutMargins(.make(vInsets: 16, hInsets: 36))
    }

    func createAction(event: State) -> UIView {
        let imageView = ImageView()
        let stack = VStack {
            VStack {
                imageView
                    .foregroundStyle(.button)
            }
            .layoutMargins(.all(16))
        }
        stack.backgroundColor(ForegroundStyle.contentSecondary.color)
        stack.onTap { [weak self] in
            self?.state.send(event)
        }

        switch event {
        case .history:
            imageView.image = Asset.Icon24px.history.image
        case .settings:
            imageView.image = Asset.Icon24px.bankAccount.image
        case .favorites:
            imageView.image = Asset.Icon24px.mainProduct.image
        }

        stack.cornerRadius = 28

        state.sink { change in
            if event == change {
                imageView
                    .foregroundStyle(.contentAccentPrimary)
                stack
                    .backgroundColor(ForegroundStyle.button.color)
            } else {
                imageView
                    .foregroundStyle(.button)
                stack
                    .backgroundColor(ForegroundStyle.contentSecondary.color)
            }
        }.store(in: &cancellable)
        return stack
    }
}

// MARK: - Configurable
extension ActionsTabsView: ConfigurableView {

    typealias Model = Props

    struct Props: Hashable {
        let id: String
        var onTap: ((State) -> Void)?

        public static func == (lhs: ActionsTabsView.Props, rhs: ActionsTabsView.Props) -> Bool {
            lhs.hashValue == rhs.hashValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }

    public func configure(with model: Props) {
        self.props = model
        subviews.forEach { $0.removeFromSuperview() }
        body().embed(in: self)
            .backgroundColor(BackgroundStyle.backgroundSecondary.color)
        print("111111111111111111 \(state.value)")
    }
}