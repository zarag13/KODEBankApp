//
//  OtpTextFieldDelegate.swift
//  AnyApp
//
//  Created by Kirill on 24.04.2024.
//

import UI
import UIKit
import AppIndependent

extension OtpTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 {
            if textField.text?.count == stackLabels.labels.count {
                self.stackLabels.state.send(.correct)
            }
            textField.text?.removeLast()
        }
        guard textField.text?.count ?? 0 < stackLabels.labels.count else {
            return false
        }
        let newText = (textField.text ?? "") + string
        textField.text = newText
        for i in 0 ..< stackLabels.labels.count {
            let currentLabel = stackLabels.labels[i]
            if i < newText.count {
                let index = newText.index(newText.startIndex, offsetBy: i)
                currentLabel.text = String(newText[index])
                if i == stackLabels.labels.count - 1 {
                    otpEvent?(.codeIsEntered(hiddenTextField.text ?? ""))
                }
            } else {
                currentLabel.text?.removeAll()
            }
        }
        stackLabels.curentSelectedLabel.send((textField.text?.count ?? 0) + 1)
        return false
    }
}
