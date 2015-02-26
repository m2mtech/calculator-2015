//
//  GraphView.swift
//  Calculator
//
//  Created by Martin Mandl on 25.02.15.
//  Copyright (c) 2015 m2m server software gmbh. All rights reserved.
//

import UIKit

class GraphView: UIView {

    var scale: CGFloat = 50.0 { didSet { setNeedsDisplay() } }
    var origin: CGPoint = CGPoint() {
        didSet {
            resetOrigin = false
            setNeedsDisplay()
        }
    }
    private var resetOrigin: Bool = true {
        didSet {
            if resetOrigin {
                setNeedsDisplay()                
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        if resetOrigin {
            origin = center
        }
        AxesDrawer(contentScaleFactor: contentScaleFactor)
            .drawAxesInRect(bounds, origin: origin, pointsPerUnit: scale)
    }

}
