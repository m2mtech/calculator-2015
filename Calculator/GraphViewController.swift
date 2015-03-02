//
//  GraphViewController.swift
//  Calculator
//
//  Created by Martin Mandl on 23.02.15.
//  Copyright (c) 2015 m2m server software gmbh. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource
{
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.dataSource = self
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: "zoom:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "move:"))
            var tap = UITapGestureRecognizer(target: self, action: "center:")
            tap.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tap)

            if !resetOrigin {
                graphView.origin = origin
            }
            graphView.scale = scale
        }
    }
    
    private struct Keys {
        static let Scale = "GraphViewController.Scale"
        static let Origin = "GraphViewController.Origin"
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var resetOrigin: Bool {
        get {
            if let originArray = defaults.objectForKey(Keys.Origin) as? [CGFloat] {
                return false
            }
            return true
        }
    }
    
    var scale: CGFloat {
        get { return defaults.objectForKey(Keys.Scale) as? CGFloat ?? 50.0 }
        set { defaults.setObject(newValue, forKey: Keys.Scale) }
    }
    
    private var origin: CGPoint {
        get {
            var origin = CGPoint()
            if let originArray = defaults.objectForKey(Keys.Origin) as? [CGFloat] {
                origin.x = originArray.first!
                origin.y = originArray.last!
            }
            return origin
        }
        set {
            defaults.setObject([newValue.x, newValue.y], forKey: Keys.Origin)
        }
    }
    
    func zoom(gesture: UIPinchGestureRecognizer) {
        graphView.zoom(gesture)
        if gesture.state == .Ended {
            scale = graphView.scale
            origin = graphView.origin
        }
    }
    
    func move(gesture: UIPanGestureRecognizer) {
        graphView.move(gesture)
        if gesture.state == .Ended {
            origin = graphView.origin
        }
    }
    
    func center(gesture: UITapGestureRecognizer) {
        graphView.center(gesture)
        if gesture.state == .Ended {
            origin = graphView.origin
        }
    }
    
    func y(x: CGFloat) -> CGFloat? {
        brain.variableValues["M"] = Double(x)
        if let y = brain.evaluate() {
            return CGFloat(y)
        }
        return nil
    }

    private var brain = CalculatorBrain()
    typealias PropertyList = AnyObject
    var program: PropertyList {
        get {
            return brain.program
        }
        set {
            brain.program = newValue
        }
    }
    
}
