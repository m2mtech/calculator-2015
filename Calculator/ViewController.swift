//
//  ViewController.swift
//  Calculator
//
//  Created by Martin Mandl on 26.01.15.
//  Copyright (c) 2015 m2m server software gmbh. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        //println("digit = \(digit)");
        
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
        
        
    }
}

