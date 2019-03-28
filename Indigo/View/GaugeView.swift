//
//  GaugeView.swift
//  Indigo
//
//  Created by Saša Vujanovic on 20/03/2019.
//  Copyright © 2019 Shauqet Cungu. All rights reserved.
//

import UIKit

class GaugeView: UIView {

    var outerBezelColor = UIColor.clear
    var outerBezelWidth: CGFloat = 0
    
    var innerBezelColor = UIColor.clear
    var innerBezelWidth: CGFloat = 0
    
    var insideColor = UIColor.clear

    func drawBackground(in rect: CGRect, context ctx: CGContext) {
        // draw the outer bezel as the largest circle
        outerBezelColor.set()
        ctx.fillEllipse(in: rect)
        
        
        // move in a little on each edge, then draw the inner bezel
        let innerBezelRect = rect.insetBy(dx: outerBezelWidth, dy: outerBezelWidth)
        innerBezelColor.set()
        ctx.fillEllipse(in: innerBezelRect)
        
        // finally, move in some more and draw the inside of our gauge
        let insideRect = innerBezelRect.insetBy(dx: innerBezelWidth, dy: innerBezelWidth)
        insideColor.set()
        ctx.fillEllipse(in: insideRect)
        
        drawSegments(in: rect, context: ctx)
    }
    
    override func draw(_ rect: CGRect) {
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
       
        drawBackground(in: rect, context: ctx)
        drawCenterDisc(in: rect, context: ctx)
    }
    var segmentWidth: CGFloat = 8
    
    var segmentColors = [barRed, barOrange, barGreen]
    
    var totalAngle: CGFloat = 270
    var rotation: CGFloat = -135
    
    
    var startt = [1,deg2rad(270*(7/10)),(deg2rad(270*(7/10))+deg2rad(270*(2/10)))/2]
    var end = [deg2rad(270*(7/10)),deg2rad(270*(2/10)),deg2rad(270*(1/10))]
    
    
    var segmentAngle = deg2rad(270/3)
    
    func drawSegments(in rect: CGRect, context ctx: CGContext) {
        // 1: Save the current drawing configuration
        ctx.saveGState()
        
        // 2: Move to the center of our drawing rectangle and rotate so that we're pointing at the start of the first segment
        ctx.translateBy(x: rect.midX, y: rect.midY)
        ctx.rotate(by: deg2rad(rotation) - (.pi / 2))
        
        // 3: Set up the user's line width
        ctx.setLineWidth(segmentWidth)
        
        // 5: Calculate how wide the segment arcs should be
        let segmentRadius = (((rect.width - segmentWidth) / 2) - outerBezelWidth) - innerBezelWidth
        
        // 6: Draw each segment
        for (index, segment) in segmentColors.enumerated() {
            // figure out where the segment starts in our arc
            let start = CGFloat(index) * startt[index]
            print (CGFloat(index))
            print(startt[index])
            print(end[index])
            // activate its color
            segment.set()
            
            // add a path for the segment
            ctx.addArc(center: .zero, radius: segmentRadius, startAngle: start, endAngle: start + end[index], clockwise: false)
            
            // and stroke it using the activated color
            ctx.drawPath(using: .stroke)
        }
        
        // 7: Reset the graphics state
        ctx.restoreGState()
    }
    var innerCenterDiscColor = UIColor.white
    var innerCenterDiscWidth: CGFloat = 25
    
    func drawCenterDisc(in rect: CGRect, context ctx: CGContext) {
        ctx.saveGState()
        ctx.translateBy(x: rect.midX, y: rect.midY)
        
        innerCenterDiscColor.set()
        ctx.fill(CGRect(x: -innerCenterDiscWidth / 2, y: -innerCenterDiscWidth / 2, width: innerCenterDiscWidth, height: innerCenterDiscWidth))
        ctx.restoreGState()
    }
    
    var needleColor = UIColor.white
    var needleWidth: CGFloat = 6
    let needle = UIView()
    
    func setUp() {
        needle.backgroundColor = needleColor
        needle.translatesAutoresizingMaskIntoConstraints = false
        
        // make the needle a third of our height
        needle.bounds = CGRect(x: 0, y: 0, width: needleWidth, height: bounds.height / 3 - 30)
        
        // align it so that it is positioned and rotated from the bottom center
        needle.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        // now center the needle over our center point
        needle.center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        addSubview(needle)
        
        valueLabel.font = valueFont
        valueLabel.text = "%"
        valueLabel.textColor = UIColor.white
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    let valueLabel = UILabel()
    var valueFont = UIFont.systemFont(ofSize: 24)
    var valueColor = UIColor.black
    
    var value: Int = 0 {
        didSet {
            // update the value label to show the exact number
            valueLabel.text = String(value)
            
            // figure out where the needle is, between 0 and 1
            let needlePosition = CGFloat(value) / 100
            
            // create a lerp from the start angle (rotation) through to the end angle (rotation + totalAngle)
            let lerpFrom = rotation
            let lerpTo = rotation + totalAngle
            
            // lerp from the start to the end position, based on the needle's position
            let needleRotation = lerpFrom + (lerpTo - lerpFrom) * needlePosition
            needle.transform = CGAffineTransform(rotationAngle: deg2rad(needleRotation))
        }
    }
}


