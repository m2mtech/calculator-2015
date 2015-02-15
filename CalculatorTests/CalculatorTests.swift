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
        brain.variableValues = ["x": 3.14]
        XCTAssertEqual(3.14, brain.pushOperand("x")!)
        XCTAssertEqual(6.28, brain.performOperation("+")!)
        //println("\(brain.program)")
    }

    func testDescription() {
        // cos(10) -> cos10
        var brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(10)!, 10)
        XCTAssertTrue(brain.performOperation("cos")! - -0.839 < 0.1)
        //XCTAssertEqual(brain.description, "cos(10)")
        XCTAssertEqual(brain.description, "cos10")
        
        // 3 - 5
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("−")!, -2)
        XCTAssertEqual(brain.description, "3 − 5")

        // 23.5
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(23.5)!, 23.5)
        XCTAssertEqual(brain.description, "23.5")

        // π
        brain = CalculatorBrain()
        XCTAssertEqual(brain.performOperation("π")!, M_PI)
        XCTAssertEqual(brain.description, "π")

        // x
        brain = CalculatorBrain()
        XCTAssertNil(brain.pushOperand("x"))
        XCTAssertEqual(brain.description, "x")
        
        // √(10) + 3 -> √10 + 3
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(10)!, 10)
        XCTAssertTrue(brain.performOperation("√")! - 3.162 < 0.1)
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertTrue(brain.performOperation("+")! - 6.162 < 0.1)
        //XCTAssertEqual(brain.description, "√(10) + 3")
        XCTAssertEqual(brain.description, "√10 + 3")
        
        // √(3 + 5)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertTrue(brain.performOperation("√")! - 2.828 < 0.1)
        XCTAssertEqual(brain.description, "√(3 + 5)")
        
        // 3 + (5 + 4) -> 3 + 5 + 4
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("+")!, 9)
        XCTAssertEqual(brain.performOperation("+")!, 12)
        //XCTAssertEqual(brain.description, "3 + (5 + 4)")
        XCTAssertEqual(brain.description, "3 + 5 + 4")

        // √(3 + √(5)) ÷ 6 -> √(3 + √5) ÷ 6
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertTrue(brain.performOperation("√")! - 2.236 < 0.1)
        XCTAssertTrue(brain.performOperation("+")! - 5.236 < 0.1)
        XCTAssertTrue(brain.performOperation("√")! - 2.288 < 0.1)
        XCTAssertEqual(brain.pushOperand(6)!, 6)
        XCTAssertTrue(brain.performOperation("÷")! - 0.381 < 0.1)
        //XCTAssertEqual(brain.description, "√(3 + √(5)) ÷ 6")
        XCTAssertEqual(brain.description, "√(3 + √5) ÷ 6")
        
        // ? + 3
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertNil(brain.performOperation("+"))
        XCTAssertEqual(brain.description, "? + 3")
        
        // √(3 + 5), cos(π) -> √(3 + 5), cosπ
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.performOperation("+")!, 8)
        XCTAssertTrue(brain.performOperation("√")! - 2.828 < 0.1)
        XCTAssertEqual(brain.performOperation("π")!, M_PI)
        XCTAssertEqual(brain.performOperation("cos")!, -1)
        //XCTAssertEqual(brain.description, "√(3 + 5), cos(π)")
        XCTAssertEqual(brain.description, "√(3 + 5), cosπ")
        
        // 3 * (5 + 4)
        brain = CalculatorBrain()
        XCTAssertEqual(brain.pushOperand(3)!, 3)
        XCTAssertEqual(brain.pushOperand(5)!, 5)
        XCTAssertEqual(brain.pushOperand(4)!, 4)
        XCTAssertEqual(brain.performOperation("+")!, 9)
        XCTAssertEqual(brain.performOperation("×")!, 27)
        XCTAssertEqual(brain.description, "3 × (5 + 4)")

//        println("\(brain.program)")
    }

}
