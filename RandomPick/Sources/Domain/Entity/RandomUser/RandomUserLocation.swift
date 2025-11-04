//
//  RandomUserLocation.swift
//  RandomProfile
//
//  Created by HYUN SUNG on 12/14/24.
//

import Foundation

// MARK: - RandomUserLocation
struct RandomUserLocation: Codable, Equatable {
    let street: Street?
    let city, state, country: String?
    let postcode: ID?
    let coordinates: Coordinates?
    let timezone: Timezone?
}

// MARK: - Street
struct Street: Codable, Equatable {
    let number: Int?
    let name: String?
}

// MARK: - Coordinates
struct Coordinates: Codable, Equatable {
    let latitude, longitude: String?
}

// MARK: - Timezone
struct Timezone: Codable, Equatable {
    let offset, description: String?
}
