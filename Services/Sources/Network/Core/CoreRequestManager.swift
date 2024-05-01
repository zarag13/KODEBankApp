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
    func detailAccount(_ id: Int) -> AppPublisher<DetailAccount>
    func detailCard(_ id: String) -> AppPublisher<DetailCard>
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
    func detailAccount(_ id: Int) -> AppPublisher<DetailAccount> {
        request(path: CorePath.detailAccount, pathParams: ["id": id])
    }
    func detailCard(_ id: String) -> Core.AppPublisher<DetailCard> {
        request(path: CorePath.detailCard, pathParams: ["id": id])
    }
}
