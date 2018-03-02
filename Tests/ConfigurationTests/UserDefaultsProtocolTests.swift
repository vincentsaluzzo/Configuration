//
//  UserDefaultsProtocolTest.swift
//  Configuration
//
//  Created by Vincent Saluzzo on 01/03/2018.
//  Copyright © 2018 Configuration. All rights reserved.
//

import Foundation
import XCTest
import Configuration

class UserDefaultsProtocolTests: XCTestCase {
    
    enum Configuration: String, ConfigurationKey {
        case test
        var `protocol`: ConfigurationProtocol { return UserDefaultsConfigurationsProtocol() }
    }
    
    override func setUp() {
        
    }
    
    func testInt() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, 10)
    }
    
    func testString() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, "Lorem ipsum")
    }
    
    func testCodable() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, CodableTest(string: "test"))
    }
    
    func testDouble() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, 3232.230479)
    }
    
}
