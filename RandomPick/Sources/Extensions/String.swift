//
//  String.swift
//  RandomProfile
//
//  Created by HYUN SUNG on 12/14/24.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
