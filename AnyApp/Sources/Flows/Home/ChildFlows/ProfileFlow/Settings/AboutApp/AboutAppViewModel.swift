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

    var event: ((Output) -> Void)?

    let lastVersion: String

    init(lastVersion: String) {
        self.lastVersion = lastVersion
    }

    func handler(_ input: Input) {
        switch input {
        case .getVersion:
            self.event?(.varsion(lastVersion))
        }
    }
}
