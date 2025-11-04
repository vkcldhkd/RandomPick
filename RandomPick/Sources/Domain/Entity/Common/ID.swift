//
//  ID.swift
//  RandomPick
//
//  Created by HYUN SUNG on 11/3/25.
//

import Foundation

enum ID: Codable, Equatable {
    case integer(Int)
    case string(String)
    case decimal(Decimal)
    case double(Double)
    case uInt64(UInt64)
    
    init(_ value: Int) {
        self = .integer(value)
        return
    }
    
    init(_ value: String) {
        self = .string(value)
        return
    }
    
    init(_ value: Decimal) {
        self = .decimal(value)
        return
    }
    
    init(_ value: Double) {
        self = .double(value)
        return
    }
    
    init(_ value: UInt64) {
        self = .uInt64(value)
        return
    }
    
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        
        if let x = try? container.decode(Decimal.self) {
            self = .decimal(x)
            return
        }
        
        if let x = try? container.decode(UInt64.self) {
            self = .uInt64(x)
            return
        }
        
        throw DecodingError.typeMismatch(
            ID.self,
            DecodingError.Context(codingPath: decoder.codingPath,
            debugDescription: "Wrong type for ID")
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .integer(x): try container.encode(x)
        case let .string(x): try container.encode(x)
        case let .decimal(x): try container.encode(x)
        case let .double(x): try container.encode(x)
        case let .uInt64(x): try container.encode(x)
        }
    }
}

extension ID{
    func getStringValue() -> String?{
        switch self {
        case let .integer(value): return "\(value)"
        case let .string(value): return value
        case let .decimal(value): return "\(value)"
        case let .double(value): return "\(value)"
        case let .uInt64(value): return "\(value)"
        }
    }
    
    func getIntValue() -> Int? {
        guard let decimalValue = self.getDecimalValue() else { return nil }
        return (decimalValue as NSDecimalNumber).intValue
    }
    
    func getUInt64() -> UInt64? {
        guard let stringValue = self.getStringValue() else { return nil }
        return UInt64(stringValue)
    }
    
    func getDecimalValue() -> Decimal? {
        guard let getStringValue = self.getStringValue() else { return nil }
        guard let decimalValue = Decimal(string: getStringValue) else { return nil }
        return decimalValue
    }
    
    func getDoubleValue() -> Double? {
        switch self {
        case let .integer(value): return Double(value)
        case let .string(value): return Double(value)
        case let .decimal(value): return value.doubleValue
        case let .double(value): return value
        case let .uInt64(value): return Double(value)
        }
    }
}
