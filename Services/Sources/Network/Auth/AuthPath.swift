import Core

enum AuthPath: String, Path, CaseIterable {
    case login
    case confirm

    var id: String {
        switch self {
        case .login:
            return "login"
        case .confirm:
            return "confirm"
        }
    }

    private var version: String {
        "151956/api/"
    }

    public var endpoint: String {
        switch self {
        case .login:
            return "\(version)auth/login"
        case .confirm:
            return "\(version)auth/confirm"
        }
    }

    var method: HttpMethod { return .post }

    var requestContext: RequestContext {
        switch self {
        case .login:
            return .auth(.login)
        case .confirm:
            return .auth(.confirm)
        }
    }
}
