//
//  RandomUserName.swift
//  RandomProfile
//
//  Created by HYUN SUNG on 12/14/24.
//

import Foundation

// MARK: - RandomUserName
struct RandomUserName: Codable, Equatable {
    let title: String?
    let first, last: String?
}

extension RandomUserName {
    func join() -> String {
        // [title] first last
        return "\(self.title ?? "") \(self.first ?? "") \(self.last ?? "")"
    }
}
