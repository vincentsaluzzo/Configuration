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
    
    enum Configuration: String {
        case test
        case unsetted
    }
    
    
    override func setUp() {
        
    }
    
    func testRunWithIntValue() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, 10)
    }
    
    func testRunWithStringValue() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, "Lorem ipsum")
    }
    
    func testRunWithCodableObject() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, CodableTest(string: "test"))
    }
    
    func testRunWithDoubleValue() {
        ConfigurationsTestUtils.testConfigurations(Configuration.test, 3232.230479)
    }
    
    func testReturnNilIfPropertyWasEmpty() {
        ConfigurationsTestUtils.testNilIfUnsetted(Configuration.unsetted)
    }
    
    func testThrowErrorIfReceiverHaveWrongTypeThanExpected() {
        ConfigurationsTestUtils.testBadReceiverType(Configuration.test)
    }
    
    func testThrowErrorWhenValueWasUnEncodable() {
        ConfigurationsTestUtils.testUnserializableCorrectly(Configuration.test)
    }
}


extension UserDefaultsProtocolTests.Configuration: ConfigurationKey {
    var `protocol`: ConfigurationProtocol { return UserDefaultsConfigurationsProtocol() }
}

