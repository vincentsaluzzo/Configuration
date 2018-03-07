//
//  UserDefaultsConfigurationsProtocol.swift
//  Configuration
//
//  Created by Vincent Saluzzo on 01/03/2018.
//  Copyright © 2018 Configuration. All rights reserved.
//

import Foundation

public class UserDefaultsConfigurationsProtocol: ConfigurationProtocol {
    
    public init() { }
    
    public func getConfiguration<Type>(withKey key: String) throws -> ConfigurationValue<Type>? {
        guard let value = UserDefaults.standard.value(forKey: key) else {
            return nil
        }
        
        if isPrimitiveForUserDefault(Type.self) {
            if let v = value as? Type {
                return ConfigurationValue(value: v)
            } else {
                throw ConfigurationError.serializationError(nil)
            }
        } else {
            guard let data = value as? Data else {
                throw ConfigurationError.serializationError(nil)
            }
            let value: ConfigurationValue<Type>?
            do {
                value = try JSONDecoder().decode(ConfigurationValue<Type>.self, from: data)
            } catch {
                throw ConfigurationError.serializationError(error)
            }
            return value
        }
    }
    
    public func setConfiguration<Type>(value: ConfigurationValue<Type>?, forKey key: String) throws {
        guard let value = value else {
            UserDefaults.standard.removeObject(forKey: key)
            return
        }
        
        if isPrimitiveForUserDefault(Type.self) {
            UserDefaults.standard.set(value.value, forKey: key)
            UserDefaults.standard.synchronize()
        } else {
            let data: Data
            do {
                data = try JSONEncoder().encode(value)
                
            } catch {
                throw ConfigurationError.serializationError(error)
            }
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func isPrimitiveForUserDefault<Type>(_ type: Type.Type) -> Bool {
        if type == String.self
        || type == Int.self
        || type == Bool.self
        || type == Float.self
        || type == Double.self
        || type == Data.self {
            return true
        } else {
            return false
        }
    }
}
