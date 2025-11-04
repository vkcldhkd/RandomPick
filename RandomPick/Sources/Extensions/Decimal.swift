//
//  Decimal.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/4/25.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
    
    var intValue: Int {
        return Int(self.doubleValue)
    }
    
    func enumeratePrecision(precision: Int) -> String {
        let number = NumberFormatter()
        number.minimumFractionDigits = precision
        number.maximumFractionDigits = precision
        number.roundingMode = .floor
        number.numberStyle = .none
        number.locale = Locale(identifier: "en_US")
        guard let result = number.string(for: self),
              result != "NaN" else { return "" }
        return result
    }
}
