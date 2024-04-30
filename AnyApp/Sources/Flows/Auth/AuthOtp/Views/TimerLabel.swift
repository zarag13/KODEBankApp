//
//  TimerLabel.swift
//  AnyApp
//
//  Created by Kirill on 23.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class TimerLabel: BackgroundPrimary {
    typealias Events = ((Event) -> Void)

    enum State {
        case process
        case refresh
        case error
    }
    enum Event {
        case attemptsFailed
        case process
        case refresh
    }

    // MARK: - Private Properties
    private var timer: Timer?
    private let timerLabelText = PassthroughSubject<String, Never>()
    private let state = CurrentValueSubject<State, Never>(.process)
    private var errorTimer: Timer?
    private var countTimerValue: TimeInterval = 10
    private var cancelable = Set<AnyCancellable>()
    private var errorCount = 5

    // MARK: - Public Properties
    public var onEvent: Events?

    // MARK: - Private Methods
    override func setup() {
        super.setup()
        setupBindings()
    }

    private func setupBindings() {
        state.sink { [weak self] state in
            self?.subviews.forEach({ $0.removeFromSuperview() })
            switch state {
            case .process:
                self?.errorTimer?.invalidate()
                self?.timerBody().embed(in: self ?? UIView())
                self?.onEvent?(.process)
                    self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                        if self?.countTimerValue == 0 {
                            self?.state.send(.refresh)
                        } else {
                            self?.createTextForTimerLabel()
                            self?.countTimerValue -= 1
                        }
                    })
            case .refresh:
                self?.timer?.invalidate()
                self?.refreshBody().embed(in: self ?? UIView())
            case .error:
                self?.timer?.invalidate()
                self?.errorCount -= 1
                self?.createErrorBody(errorcount: self?.errorCount ?? 1).embed(in: self ?? UIView())
                guard self?.errorCount != 0 else {
                    self?.onEvent?(.attemptsFailed)
                    return
                }
                self?.errorTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                    if self?.countTimerValue ?? 0 > 2 {
                        self?.countTimerValue -= 2
                    }
                    self?.onEvent?(.process)
                    self?.state.send(.process)
                })
            }
        }.store(in: &cancelable)
    }

    private func timerBody() -> UIView {
        createTextForTimerLabel()
        let label = Label(foregroundStyle: .textSecondary, fontStyle: .caption13)
        timerLabelText.sink { value in
            label.text = "\(Entrance.repeatAfter) \(value)"
        }.store(in: &cancelable)

        return BackgroundView(vPadding: 20) {
            label
        }
    }

    private func createTextForTimerLabel() {
        let minutes = Int(countTimerValue) / 60 % 60
        let seconds = Int(countTimerValue) % 60
        timerLabelText.send(String(format: "%02i:%02i", minutes, seconds))
    }

    private func refreshBody() -> UIView {
        HStack(spacing: 16) {
            ImageView(image: Asset.Icon24px.repay.image, foregroundStyle: .contentAccentPrimary)
                .huggingPriority(.defaultHigh, axis: .horizontal)
            Label(text: Entrance.sendCodeAgain, foregroundStyle: .textPrimary, fontStyle: .caption13)
                .huggingPriority(.defaultLow, axis: .horizontal)
        }
        .layoutMargins(.make(vInsets: 16))
        .onTap { [weak self] in
            self?.countTimerValue = 10
            self?.onEvent?(.refresh)
        }
    }

    private func createErrorBody(errorcount: Int) -> UIView {
        let label = Label(foregroundStyle: .indicatorContentError, fontStyle: .caption13)
        label.text = "\(Entrance.invalidCode) \(errorCount) \(Plurals.attempt(errorCount))"
        return BackgroundView(vPadding: 20) {
            label
        }
    }

    // MARK: - Public Methods
    public func handle(_ state: State) {
        switch state {
        case .process:
            if self.state.value != .process {
                self.state.send(.process)
            }
        case .refresh:
            self.state.send(.refresh)
        case .error:
            self.state.send(.error)
        }
    }
}
