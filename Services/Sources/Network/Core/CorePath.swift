//
//  CorePath.swift
//  Services
//
//  Created by Kirill on 26.04.2024.
//

import Core

enum CorePath: String, Path, CaseIterable {
    case profile

    var id: String {
        switch self {
        case .profile:
            return "profile"
        }
    }

    private var version: String {
        "6096726/api/"
    }

    public var endpoint: String {
        switch self {
        case .profile:
            return "\(version)core/profile"
        }
    }

    var method: HttpMethod { return .get }

    var requestContext: RequestContext {
        switch self {
        case .profile:
            return .core(.profile)
        }
    }
}

// MARK: - Pathfinder support
extension CorePath {

    var name: String {
        switch self {
        case .profile:
            return "Receive Profile Data"
        }
    }

    var tag: String { "Core" }
}
