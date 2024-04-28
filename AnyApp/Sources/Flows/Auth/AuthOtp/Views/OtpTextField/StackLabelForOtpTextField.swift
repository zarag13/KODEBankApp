//
//  StackLabelForOtpTextField.swift
//  AnyApp
//
//  Created by Kirill on 24.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine

final class StackLabelForOtpTextField: BackgroundPrimary {
    enum State {
        case error
        case correct
    }

    // MARK: - Private Properties
    private var cancelable = [AnyCancellable]()
    private var curentSelectedLabel = PassthroughSubject<Int, Never>()
    private var state = CurrentValueSubject<State, Never>(.correct)

    // MARK: - Public Properties
    public var labels = [Label]()

    // MARK: - Private Methods
    private func body(leght: Int) -> UIView {
        if leght % 2 == 0 {
            return HStack(alignment: .center, distribution: .fill, spacing: 6) {
                ForEach(collection: 1...(leght / 2), distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.setupLabel(tagForLineView: value)
                }
                createSeparatorForTextField()
                ForEach(collection: (leght / 2 + 1)...leght, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                    self.setupLabel(tagForLineView: value)
                }
            }
        } else {
            return ForEach(collection: 1...leght, distribution: .fillEqually, spacing: 6, axis: .horizontal) { value in
                self.setupLabel(tagForLineView: value)
            }
        }
    }

    private func setupLabel(tagForLineView: Int) -> Label {
        let label = Label(text: "")
            .minWidth(40)
            .minHeight(48)
            .cornerRadius(12)
            .clipsToBounds(true)
            .textAlignment(.center)
            .fontStyle(FontStyle.subtitle)
            .huggingPriority(.defaultLow, axis: .horizontal)
            .backgroundColor(ForegroundStyle.contentSecondary.color)
            .userInteraction(enabled: true)
        let lineView = setupLineView(tag: tagForLineView)
        label.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.trailing.leading.equalToSuperview().inset(8)
            make.height.equalTo(2)
        }
        labels.append(label)
        setupBindings(lineView: lineView, label: label)
        return label
    }

    private func setupLineView(tag: Int) -> UIView {
        let lineView = BackgroundView()
        lineView.backgroundStyle(.indicatorContentSuccess)
        lineView.tag = tag
        lineView.isHidden = true
        return lineView
    }

    private func setupBindings(lineView: UIView, label: Label) {
            state.sink { [weak label] state in
                switch state {
                case .error:
                    label?.foregroundStyle(.indicatorContentError)
                case .correct:
                    label?.foregroundStyle(.textPrimary)
                }
            }.store(in: &cancelable)
        curentSelectedLabel.sink { [weak lineView] value in
            if lineView?.tag == value {
                lineView?.isHidden = false
            } else {
                lineView?.isHidden = true
            }
        }.store(in: &cancelable)
    }

    private func createSeparatorForTextField() -> UIView {
        BackgroundView { view in
            let lineView = UIView()
            lineView.backgroundColor = ForegroundStyle.contentTertiary.color
            view.addSubview(lineView)
            lineView.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(2)
            }
        }
        .width(10)
    }

    // MARK: - Public Methods
    public func configure(lenght: Int = 6) -> Self {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.labels = []
        body(leght: lenght).embed(in: self)
        return self
    }

    public func handle(_ state: State) {
        self.state.send(state)
    }

    public func handleSelectedLable(_ curent: Int) {
        self.curentSelectedLabel.send(curent)
    }
}
