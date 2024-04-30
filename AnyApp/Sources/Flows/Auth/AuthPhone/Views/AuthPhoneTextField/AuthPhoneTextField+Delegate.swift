//
//  AuthPhoneTextField+Delegate.swift
//  AnyApp
//
//  Created by Kirill on 30.04.2024.
//

import UIKit

extension AuthPhoneTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "+7 "
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.state.send(.corrcet)
        guard var text = textField.text else { return false }
        if range.length == 1 {
            text.removeLast()
            if text.last == " " {
                text.removeLast()
            }
            if text.last == ")" || text.last == "("{
                text.removeLast()
            }
            text = self.maskText(text)
            if text == "+7" {
                text = "+7 "
            }
            self.text = text
            textField.text = text
        } else {
            let maskText = self.maskText(text + string)
            textField.text = maskText
            self.text = maskText
        }
        return false
    }

    private func maskText(_ text: String) -> String {
        if text.count < 7 {
            return text.maskEnterPhoneNumber(pattern: "+7 ### ### ## ##")
        } else {
            return text.maskEnterPhoneNumber(pattern: "+7 (###) ### ## ##")
        }
    }
}
