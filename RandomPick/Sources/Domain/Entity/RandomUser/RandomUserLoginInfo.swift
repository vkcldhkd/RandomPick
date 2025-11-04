//
//  RandomUserLoginInfo.swift
//  RandomProfile
//
//  Created by HYUN SUNG on 12/14/24.
//

import Foundation

// MARK: - RandomUserLoginInfo
struct RandomUserLoginInfo: Codable, Equatable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}
