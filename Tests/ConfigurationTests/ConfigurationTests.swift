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

struct BadCodableTest: Codable {
    var bad: [String: AnyObject]?
    
    enum CodingKeys: String, CodingKey {
        case bad
    }
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bad = try container.decodeIfPresent([String: AnyObject].self, forKey: .bad)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(bad, forKey: .bad)
    }
}

class ConfigurationsTestUtils {
    
    static func testUnserializableCorrectly<Configuration: ConfigurationKey>(_ configuration: Configuration) {
//        var badObject = BadCodableTest()
//        badObject.bad = ["Test": NSNumber(value: 10)]
        XCTAssertThrowsError(try configuration.set(Double.infinity))
    }
    
    static func testBadReceiverType<Configuration: ConfigurationKey>(_ configuration: Configuration) {
        do {
            try configuration.set("Test")
        } catch {
            XCTAssert(false, "Can't set value Test for Configuration \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
        
        XCTAssertThrowsError(try configuration.get() as Double?)
    }
    
    static func testNilIfUnsetted<Configuration: ConfigurationKey>(_ configuration: Configuration) {
        do {
            try configuration.set(nil as String?)
        } catch {
            XCTAssert(false, "Can't reset value for Configuration \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
        do {
            let settedValue: String? = try configuration.get()
            XCTAssertNil(settedValue, "\(configuration.key) with protocol \(configuration.`protocol`) expect nil but find not nil \(String(describing: settedValue))")
        } catch {
            XCTAssert(false, "Getting \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
    }
    
    static func testConfigurations<Configuration: ConfigurationKey, Type: Codable>(_ configuration: Configuration, _ value: Type) where Type: Equatable {
        do {
            try configuration.set(value)
        } catch {
            XCTAssert(false, "Configuration \(value) with type \(Type.self) for \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
        do {
            let settedValue: Type? = try configuration.get()
            XCTAssertNotNil(settedValue, "\(Type.self) setted for \(configuration.key) with protocol \(configuration.`protocol`) expect \(value) but find nil")
            XCTAssert(settedValue == value, "Double setted for \(configuration.key) with protocol \(configuration.`protocol`) expect \(value) but find \(String(describing: settedValue))")
            
        } catch {
            XCTAssert(false, "Getting \(value) with type \(Type.self) for \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
    }
    
    static func testConfigurations<Configuration: ConfigurationKey, Type: Codable>(_ configuration: Configuration, _ value: Type) {
        do {
            try configuration.set(value)
        } catch {
            XCTAssert(false, "Configuration \(value) with type \(Type.self) for \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
        do {
            let settedValue: Type? = try configuration.get()
            XCTAssertNotNil(settedValue, "\(Type.self) setted for \(configuration.key) with protocol \(configuration.`protocol`) expect \(value) but find nil")
            
        } catch {
            XCTAssert(false, "Getting \(value) with type \(Type.self) for \(configuration.key) with protocol \(configuration.`protocol`) throw an error (\(error))")
        }
    }
}
