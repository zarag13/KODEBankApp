//
//  DepositListReponse.swift
//  Services
//
//  Created by Kirill on 30.04.2024.
//

import Foundation

public struct DepositListReponse: Decodable {
    enum Status: String, Decodable{
        case active = "ACTIVE"
    }
    let depositID: Int
    let name: String
    let balance: Int
    let currency: String
    let status: Status
    enum CodingKeys: String, CodingKey {
        case depositID = "depositId"
        case name, balance, currency, status
    }
}
