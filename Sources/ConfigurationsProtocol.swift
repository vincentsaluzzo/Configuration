//
//  ConfigurationsProtocol.swift
//  Configuration
//
//  Created by Vincent Saluzzo on 01/03/2018.
//  Copyright © 2018 Configuration. All rights reserved.
//

import Foundation

public enum ConfigurationError: Swift.Error {
    case underlying(Swift.Error)
    case serializationError(Swift.Error?)
}

public protocol ConfigurationProtocol {
    func getConfiguration<Type>(withKey: String) throws -> ConfigurationValue<Type>?
    func setConfiguration<Type>(value: ConfigurationValue<Type>?, forKey: String) throws
}
