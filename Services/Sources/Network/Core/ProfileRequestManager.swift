//
//  ProfileRequestManager.swift
//  Services
//
//  Created by Kirill on 26.04.2024.
//

import Core
import Combine
import Alamofire

public protocol ProfiletManagerAbstract: AnyObject {

    func profileData() -> AppPublisher<ProfileResponse>
}

final class ProfileRequestManager: NetworkRequestManager, ProfiletManagerAbstract {
    func profileData() -> AppPublisher<ProfileResponse> {
        request(path: CorePath.profile)
    }
}

//curl --request GET \
///--url https://stoplight.io/mocks/kode-api/kode-bank/6096726/api/core/profile \
//--header 'Accept: application/json' \
//--header 'Authorization: Bearer 1aa23'
