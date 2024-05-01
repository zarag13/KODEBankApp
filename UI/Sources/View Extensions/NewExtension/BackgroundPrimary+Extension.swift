//
//  BackgroundPrimary+Extension.swift
//  AnyApp
//
//  Created by Kirill on 23.04.2024.
//

extension BackgroundPrimary {
    @discardableResult
    public func roundingFiftyPercentFromWidth() -> Self {
        self.cornerRadius(self.frame.width / 2)
        return self
    }
    @discardableResult
    public func roundingFiftyPercentFromHeight() -> Self {
        self.cornerRadius(self.frame.height / 2)
        return self
    }
}
