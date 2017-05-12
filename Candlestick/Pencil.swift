//
//  Pencil.swift
//  Candlestick
//
//  Created by Mac Mini on 5/11/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Foundation


/*

 USE:
 
 let context = NSGraphicsContext.current()?.cgContext
 context?.rect( 10,  10, 100, 100)
 context?.rect(110, 110,  50,  30, borderColor: Color.blue)
 context?.line(120, 120, 200, 200)
 context?.line( 20, 120,  30, 200, lineColor: Color.green, lineWidth: 2.0)
 context?.circle(40, 120, 50, borderColor: Color.red)
 context?.ellipse(80, 120, 50, 80, borderColor: Color.green)

 */


extension CGContext {
    
    func line(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int, lineColor: CGColor = CGColor.black, lineWidth: CGFloat = 1.0) {
        self.setLineWidth(lineWidth)
        self.setStrokeColor(lineColor)
        
        self.move(to: CGPoint(x: x1, y: y1))
        self.addLine(to: CGPoint(x: x2, y: y2))
        self.drawPath(using: .fillStroke)
    }
    
    // TODO: Add rotation
    func rect(_ x: Int, _ y: Int, _ width: Int, _ height: Int, radius: CGFloat = 0.0, borderColor: CGColor = CGColor.black, borderWidth: CGFloat = 1.0, fillColor: CGColor = CGColor.clear) {
        let path = CGMutablePath()
        let rect = CGRect(x: x, y: y, width: width, height: height)
        
        let pointMaxXMinY = CGPoint(x: rect.maxX, y: rect.minY)
        let pointMaxXMaxY = CGPoint(x: rect.maxX, y: rect.maxY)
        let pointMinXMaxY = CGPoint(x: rect.minX, y: rect.maxY)
        let pointMinXMinY = CGPoint(x: rect.minX, y: rect.minY)
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addArc(tangent1End: pointMaxXMinY, tangent2End: pointMaxXMaxY, radius: radius)
        path.addArc(tangent1End: pointMaxXMaxY, tangent2End: pointMinXMaxY, radius: radius)
        path.addArc(tangent1End: pointMinXMaxY, tangent2End: pointMinXMinY, radius: radius)
        path.addArc(tangent1End: pointMinXMinY, tangent2End: pointMaxXMinY, radius: radius)
        path.closeSubpath()
        
        self.setLineWidth(borderWidth)
        self.setStrokeColor(borderColor)
        self.setFillColor(fillColor)
        
        self.addPath(path)
        self.drawPath(using: .fillStroke)
    }
    
    func circle(_ x: Int, _ y: Int, _ radius: Int, borderColor: CGColor = CGColor.black, borderWidth: CGFloat = 1.0, fillColor: CGColor = CGColor.clear) {
        let rect = CGRect(x: x, y: y, width: radius, height: radius)
        
        self.setLineWidth(borderWidth)
        self.setStrokeColor(borderColor)
        self.setFillColor(fillColor)
        
        self.addEllipse(in: rect)
        self.drawPath(using: .fillStroke)
    }
    
    // TODO: Add rotation
    func ellipse(_ x: Int, _ y: Int, _ width: Int, _ height: Int, borderColor: CGColor = CGColor.black, borderWidth: CGFloat = 1.0, fillColor: CGColor = CGColor.clear) {
        let rect = CGRect(x: x, y: y, width: width, height: height)
        
        self.setLineWidth(borderWidth)
        self.setStrokeColor(borderColor)
        self.setFillColor(fillColor)
        
        self.addEllipse(in: rect)
        self.drawPath(using: .fillStroke)
    }
    
    // path(100,100,120,120,130,150,180,190,120,110) pairs of coords
    func path() {
        // TODO:
    }
    
    func text(_ x: Int, _ y: Int, text: String, color: CGColor = CGColor.black) {
        // TODO:
    }
    
}

// End
