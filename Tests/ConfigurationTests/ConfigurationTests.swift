//
//  ConfigurationsTests.swift
//  Configuration
//
//  Created by Vincent Saluzzo on 28/02/2018.
//  Copyright © 2018 Configuration. All rights reserved.
//

import Foundation
import XCTest
import Configuration

struct CodableTest: Codable {
    var string: String
}

class ConfigurationsTestUtils {
    
    static func testConfigurations<Configuration: ConfigurationKey, Type: Codable>(_ Configuration: Configuration, _ value: Type) where Type: Equatable {
        do {
            try Configuration.set(value)
        } catch {
            XCTAssert(false, "Configuration \(value) with type \(Type.self) for \(Configuration.key) with protocol \(Configuration.`protocol`) throw an error (\(error))")
        }
        do {
            let settedValue: Type? = try Configuration.get()
            XCTAssertNotNil(settedValue, "\(Type.self) setted for \(Configuration.key) with protocol \(Configuration.`protocol`) expect \(value) but find nil")
            XCTAssert(settedValue == value, "Double setted for \(Configuration.key) with protocol \(Configuration.`protocol`) expect \(value) but find \(String(describing: settedValue))")
            
        } catch {
            XCTAssert(false, "Getting \(value) with type \(Type.self) for \(Configuration.key) with protocol \(Configuration.`protocol`) throw an error (\(error))")
        }
    }
    
    static func testConfigurations<Configuration: ConfigurationKey, Type: Codable>(_ Configuration: Configuration, _ value: Type) {
        do {
            try Configuration.set(value)
        } catch {
            XCTAssert(false, "Configuration \(value) with type \(Type.self) for \(Configuration.key) with protocol \(Configuration.`protocol`) throw an error (\(error))")
        }
        do {
            let settedValue: Type? = try Configuration.get()
            XCTAssertNotNil(settedValue, "\(Type.self) setted for \(Configuration.key) with protocol \(Configuration.`protocol`) expect \(value) but find nil")
            
        } catch {
            XCTAssert(false, "Getting \(value) with type \(Type.self) for \(Configuration.key) with protocol \(Configuration.`protocol`) throw an error (\(error))")
        }
    }
}
