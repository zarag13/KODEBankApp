//
//  String+Extension.swift
//  AnyApp
//
//  Created by Kirill on 24.04.2024.
//

import Foundation

extension String {
    func localizedPlural(_ arg: Int) -> String {
        let formatSrting = NSLocalizedString(self, comment: "\(self) error")
        return Self.localizedStringWithFormat(formatSrting, arg)
    }
}
