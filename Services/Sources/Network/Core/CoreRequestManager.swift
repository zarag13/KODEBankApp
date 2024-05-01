//
//  ProfileRequestManager.swift
//  Services
//
//  Created by Kirill on 26.04.2024.
//

import Core
import Combine
import Alamofire

public protocol CoreManagerAbstract: AnyObject {

    func profileData() -> AppPublisher<ProfileResponse>
    func accountListData() -> AppPublisher<AccountListResponse>
    func depositListData() -> AppPublisher<DepositListReponse>
}

final class CoreRequestManager: NetworkRequestManager, CoreManagerAbstract {
    func profileData() -> AppPublisher<ProfileResponse> {
        request(path: CorePath.profile)
    }
    func accountListData() -> AppPublisher<AccountListResponse> {
        request(path: CorePath.accocuntList)
    }
    func depositListData() -> AppPublisher<DepositListReponse> {
        request(path: CorePath.depositList)
    }
}
