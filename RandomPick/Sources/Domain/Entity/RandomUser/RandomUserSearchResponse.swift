//
//  RandomUserSearchResponse.swift
//  RandomProfile
//
//  Created by HYUN SUNG on 12/14/24.
//

import Foundation

// MARK: - RandomUserSearchResponse
struct RandomUserSearchResponse: Codable {
    let results: [RandomUser]?
    let info: RandomUserSearchInfo?
}

// MARK: - Info
struct RandomUserSearchInfo: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}


