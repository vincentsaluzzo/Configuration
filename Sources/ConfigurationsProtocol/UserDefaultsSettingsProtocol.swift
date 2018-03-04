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
    
    public func getConfiguration<Type: Codable>(withKey key: String) throws -> Type? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        let value: Type?
        do {
            value = try JSONDecoder().decode(Type.self, from: data)
        } catch {
            throw ConfigurationError.serializationError(error)
        }
        return value
    }
    
    public func setConfiguration<Type: Codable>(value: Type?, forKey key: String) throws {
        guard let value = value else {
            UserDefaults.standard.removeObject(forKey: key)
            return
        }
        let data: Data
        do {
            data = try JSONEncoder().encode(value)
            
        } catch {
            throw ConfigurationError.serializationError(error)
        }
        UserDefaults.standard.set(data, forKey: key)
    }
}
