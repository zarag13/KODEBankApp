//
//  ProfileResponse.swift
//  Services
//
//  Created by Kirill on 26.04.2024.
//
import Foundation

public struct ProfileResponse: Decodable {
    public let id: Int
    public let firstName: String
    public let middleName: String
    public let lastName: String
    public let country: String
    public let phone: String
}
