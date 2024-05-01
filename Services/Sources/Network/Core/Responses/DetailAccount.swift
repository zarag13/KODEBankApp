//
//  DetailAccount.swift
//  Services
//
//  Created by Kirill on 01.05.2024.
//

import Foundation

public struct DetailAccount: Decodable {
    public enum Currency: String, Decodable {
        case rub = "RUB"
    }
    public let accountID: Int
    public let number: String
    public let balance: Int
    public let currency: Currency
    public let status: String

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case number, balance, currency, status
    }
}
