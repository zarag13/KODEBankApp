//
//  AboutAppViewModel.swift
//  AnyApp
//
//  Created by Kirill on 22.04.2024.
//

import Services

final class AboutAppViewModel {

    enum Input {
        case getVersion
    }
    enum Output {
        case varsion(String)
    }
    // MARK: - Private Properties
    private let lastVersion: String

    // MARK: - Public Properties
    public var event: ((Output) -> Void)?

    init(lastVersion: String) {
        self.lastVersion = lastVersion
    }

    // MARK: - Public Methods
    func handler(_ input: Input) {
        switch input {
        case .getVersion:
            self.event?(.varsion(lastVersion))
        }
    }
}
