//
//  UITextField+Extension.swift
//  AnyApp
//
//  Created by Kirill on 16.04.2024.
//

import UIKit
import Combine

extension UITextField {
    public var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)
            .compactMap({ $0.object as? UITextField })
            .map({ $0.text ?? "" })
            .eraseToAnyPublisher()
    }
}
