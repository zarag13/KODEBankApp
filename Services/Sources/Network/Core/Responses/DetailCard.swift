//
//  DetailCard.swift
//  Services
//
//  Created by Kirill on 01.05.2024.
//

import Foundation

public struct DetailCard: Decodable {

    public enum PaymentSystem: String, Decodable {
        case visa = "VISA"
    }
    public enum Status: String, Decodable {
        case active = "Активна"
    }

    public let id, accountID: Int
    public let name, number: String
    public let expiredAt: String
    public let status: Status

    public let paymentSystem: PaymentSystem
    enum CodingKeys: String, CodingKey {
        case id
        case accountID = "accountId"
        case number, expiredAt, paymentSystem, status, name
    }
}
