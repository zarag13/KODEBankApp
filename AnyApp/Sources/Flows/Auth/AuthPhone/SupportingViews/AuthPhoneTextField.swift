//
//  AuthPhoneTextField.swift
//  AnyApp
//
//  Created by Kirill on 14.04.2024.
//

import UI
import UIKit
import AppIndependent
import Combine


extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
            .compactMap({ $0.object as? UITextField })
            .map({ $0.text ?? "" })
            .eraseToAnyPublisher()
    }
}

extension String {
    func formatUserInput(pattern: String) -> String {
        var inputCollection = Array(self)
        var resultCollection: Array<Character> = []
        for i in 0 ..< pattern.count {
            let patternCharIndex = String.Index(utf16Offset: i, in: pattern)
            let patternChar = pattern[patternCharIndex]
            guard let nextInputChar = inputCollection.first else { break }
            if (patternChar == nextInputChar || patternChar == "#") {
                resultCollection.append(nextInputChar)
                inputCollection.removeFirst()
            } else {
                resultCollection.append(patternChar)
            }
        }
        return String(resultCollection)
    }
}

final class AuthPhoneTextField: BackgroundPrimary {
    enum AuthTFActivityIndicatorState {
        case beginning
        case stop
    }

    private var cancelable = [AnyCancellable]()
    @Published var isActivate: AuthTFActivityIndicatorState = .stop
    private let spinner = MediumSpinner(style: .button)

    override func setup() {
        super.setup()
        body().embed(in: self)
        $isActivate.sink { [weak self] state in
            switch state {
            case .beginning:
                self?.spinner.isHidden = false
                self?.spinner.start()
            case .stop:
                self?.spinner.isHidden = true
                self?.spinner.stop()
            }
        }.store(in: &cancelable)
    }

    private func body() -> UIView {
        VStack {
            HStack(spacing: 16) {
                ImageView(image: Asset.user.image, foregroundStyle: .contentPrimary)
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                createTextField()
                spinner
                    .huggingPriority(.defaultHigh, axis: .horizontal)
                    .tintColor(.white)
            }
            .layoutMargins(.init(top: 14, left: 24, bottom: 14, right: 16))
        }
        .backgroundColor(ForegroundStyle.contentPrimary.color).cornerRadius(26)
    }

    private func createTextField() -> TextField {
        TextField(placeholder: "Телефон", configurator: { textField in
            textField.becomeFirstResponder()
            textField.textPublisher
                .map { ($0.formatUserInput(pattern: "+7 (###) ### ## ##" )) }
                .assign(to: \.text, on: textField)
                .store(in: &cancelable)
        })
            .huggingPriority(.defaultLow, axis: .horizontal)
            .keyboardType(.numberPad)
    }
}
