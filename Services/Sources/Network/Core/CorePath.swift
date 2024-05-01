//
//  CorePath.swift
//  Services
//
//  Created by Kirill on 26.04.2024.
//

import Core

enum CorePath: String, Path, CaseIterable {
    case profile
    case accocuntList
    case depositList
    case detailAccount
    case detailCard

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .accocuntList:
            return "accocuntList"
        case .depositList:
            return "depositList"
        case .detailAccount:
            return "detailAccount"
        case .detailCard:
            return "detailCard"
        }
    }

    private var version: String {
        "6096726/api/"
    }

    public var endpoint: String {
        switch self {
        case .profile:
            return "\(version)core/profile"
        case .accocuntList:
            return "\(version)core/account/list"
        case .depositList:
            return "\(version)core/deposit/list"
        case .detailAccount:
            return "\(version)core/account/{id}"
        case .detailCard:
            return "\(version)core/card/{id}"
        }
    }

    var method: HttpMethod { return .get }

    var requestContext: RequestContext {
        switch self {
        case .profile:
            return .core(.profile)
        case .accocuntList:
            return .core(.accountList)
        case .depositList:
            return .core(.depositList)
        case .detailAccount:
            return .core(.account)
        case .detailCard:
            return .core(.card)
        }
    }
}

// MARK: - Pathfinder support
extension CorePath {

    var name: String {
        switch self {
        case .profile:
            return "Receive Profile Data"
        case .accocuntList:
            return "Receive Account List"
        case .depositList:
            return "Receive Deposit List"
        case .detailAccount:
            return "Receive Detail Account"
        case .detailCard:
            return "Receive Detail Card"
        }
    }

    var tag: String { "Core" }
}
