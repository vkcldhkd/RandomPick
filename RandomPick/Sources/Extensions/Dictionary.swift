//
//  Dictionary.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import Foundation

extension Dictionary {
    func toData(options: JSONSerialization.WritingOptions = []) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch {
            print("Dictionary toData Error: \(error)")
            return nil
        }
    }
}
