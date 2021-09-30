//
//  Business.swift
//  FilRouge
//
//  Created by Student08 on 01/09/2021.
//

import Foundation
struct BusinessJSON: Codable {
    let businesses: [Business]
    let total: Int
}

struct Business: Codable {
    let alias: String
    let categories: [BusinessCategory]
    let coordinates: BusinessCoordinates
    let distance: Double
    let id: String
    let imageUrl: String?
    let isClosed: Bool
    let location: BusinessLocation
    let name: String
    let phone: String
    let displayPhone: String
    let price: String?
    let rating: Float
    let reviewCount: Int
    let url: URL
}

struct BusinessCategory: Codable {
    let alias: String
    let title: String
}

struct BusinessCoordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct BusinessLocation: Codable {
    let address1: String?
    let address2: String?
    let address3: String?
    let city: String
    let country: String
    let displayAddress: [String]
    let zipCode: String
}
