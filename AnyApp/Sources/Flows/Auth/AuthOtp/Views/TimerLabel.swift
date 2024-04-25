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
    enum State {
        case process
        case refresh
        case error
    }
    private var timer: Timer?
    private let timerLabelText = PassthroughSubject<String, Never>()
    let state = CurrentValueSubject<State, Never>(.process)
    private var errorTimer: Timer?
    private var countTimerValue: TimeInterval = 180
    private var cancelable = Set<AnyCancellable>()
    private var errorCount = 5

    override func setup() {
        super.setup()
        state.sink { [weak self] state in
            self?.subviews.forEach({ $0.removeFromSuperview() })
            switch state {
            case .process:
                self?.errorTimer?.invalidate()
                self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                    let minutes = Int(self?.countTimerValue ?? 0) / 60 % 60
                    let seconds = Int(self?.countTimerValue ?? 0) % 60
                    if self?.countTimerValue == 0 {
                        self?.state.send(.refresh)
                    } else {
                        self?.countTimerValue -= 1
                        self?.timerLabelText.send(String(format: "%02i:%02i", minutes, seconds))
                    }
                })
                self?.timerBody().embed(in: self ?? UIView())
                self?.countTimerValue = 180
                self?.timer?.fire()
            case .refresh:
                self?.timer?.invalidate()
                self?.refreshBody().embed(in: self ?? UIView())
            case .error:
                self?.timer?.invalidate()
                self?.createErrorBody(errorcount: self?.errorCount ?? 1).embed(in: self ?? UIView())
                self?.errorCount -= 1
                self?.errorTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
                    if self?.state.value == .error {
                        self?.state.send(.process)
                    }
                })
            }
        }.store(in: &cancelable)
    }

    private func timerBody() -> UIView {
        let label = Label(foregroundStyle: .textSecondary, fontStyle: .caption13)
        timerLabelText.sink { value in
            label.text = "\(Entrance.repeatAfter) \(value)"
        }.store(in: &cancelable)
        return BackgroundView(vPadding: 20) {
            label
        }
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
            self?.state.send(.process)
        }
    }
    private func createErrorBody(errorcount: Int) -> UIView {
        let label = Label(foregroundStyle: .indicatorContentError, fontStyle: .caption13)
        label.text = "\(Entrance.invalidCode) \(errorCount) \(Plurals.attempt(errorCount))"
        return BackgroundView(vPadding: 20) {
            label
        }
    }
}
