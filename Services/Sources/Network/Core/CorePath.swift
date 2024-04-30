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

    var id: String {
        switch self {
        case .profile:
            return "profile"
        case .accocuntList:
            return "accocuntList"
        case .depositList:
            return "depositList"
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
        }
    }

    var tag: String { "Core" }
}
