//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Martin Mandl on 26.01.15.
//  Copyright (c) 2015 m2m server software gmbh. All rights reserved.
//

import UIKit
import XCTest

class CalculatorTests: XCTestCase {
    
    func testPushOperandVariable() {
        var brain = CalculatorBrain()
        XCTAssertNil(brain.pushOperand("x"))
        XCTAssertEqual(brain.program[0] as String, "x")
        //println("\(brain.program)")
    }
}
