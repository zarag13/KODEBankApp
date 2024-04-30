//
//  AccountListResponse.swift
//  Services
//
//  Created by Kirill on 30.04.2024.
//

import Foundation
//AccountListResponse
public struct AccountListResponse: Decodable {
    public let accounts: [Account]
}

public struct Account: Decodable {
    public enum Status: String, Decodable {
        case active = "Активен"
    }
    public enum Currency: String, Decodable {
        case rub = "RUB"
    }
    public let cards: [Card]
    public let number: String
    public let status: Status
    public let balance: Int
    public let currency: Currency
    public let accountID: Int
    enum CodingKeys: String, CodingKey {
        case cards, number, status, balance, currency
        case accountID = "accountId"
    }
}

public struct Card: Decodable {
    public enum Status: String, Decodable {
        case active = "ACTIVE"
        case deactivated = "DEACTIVATED"
    }
    public enum PaymentSystem: String, Decodable {
        case visa = "Visa"
        case masterCard = "MasterCard"
        case mir = "МИР"
    }
    public enum CardType: String, Decodable {
        case physical, digital
    }
    public let name, number, status, cardID: String
    public let cardType: CardType
    public let paymentSystem: PaymentSystem
    enum CodingKeys: String, CodingKey {
        case name, number, status
        case cardID = "card_id"
        case cardType = "card_type"
        case paymentSystem = "payment_system"
    }
}
