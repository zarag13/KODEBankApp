//
//  DepositListReponse.swift
//  Services
//
//  Created by Kirill on 30.04.2024.
//

import Foundation
public struct DepositListReponse: Decodable {
    public let deposits: [Deposit]
}

public struct Deposit: Decodable {
    public enum Status: String, Decodable {
        case active = "ACTIVE"
    }
    public enum Currency: String, Decodable {
        case rub = "RUB"
    }
    public let depositID: Int
    public let name: String
    public let balance: Int
    public let currency: Currency
    public let status: Status
    enum CodingKeys: String, CodingKey {
        case depositID = "depositId"
        case name, balance, currency, status
    }
}
