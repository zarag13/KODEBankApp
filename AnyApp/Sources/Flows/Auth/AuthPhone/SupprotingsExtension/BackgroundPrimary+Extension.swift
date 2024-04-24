//
//  BackgroundPrimary+Extension.swift
//  AnyApp
//
//  Created by Kirill on 23.04.2024.
//

import UI

extension BackgroundPrimary {
    @discardableResult
    public func roundingFiftyPercent() -> Self {
        self.cornerRadius(self.frame.width / 2)
        return self
    }
}

