//
//  Configuration.swift
//  Configuration
//
//  Created by Vincent Saluzzo on 01/03/2018.
//  Copyright © 2018 Configuration. All rights reserved.
//

import Foundation

public struct ConfigurationValue<T: Codable>: Codable {
    var value: T
    public init(value: T) {
        self.value = value
    }
}

public protocol ConfigurationKey: RawRepresentable {
    var `protocol`: ConfigurationProtocol { get }
}

extension ConfigurationKey {
    public var key: String {
        return "\(rawValue)"
    }
    
    public func get<Type: Codable>() throws -> Type? {
        let ConfigurationValue: ConfigurationValue<Type>? = try `protocol`.getConfiguration(withKey: key)
        return ConfigurationValue?.value
    }
    
    public func set<Type: Codable>(_ value: Type?) throws {
        if let value = value {
            let configurationValue = ConfigurationValue(value: value)
            try `protocol`.setConfiguration(value: configurationValue, forKey: key)
        } else {
            try `protocol`.setConfiguration(value: nil as ConfigurationValue<Type>?, forKey: key)
        }
    }
}
