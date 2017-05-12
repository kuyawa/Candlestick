//
//  Canvas.swift
//  Candlestick
//
//  Created by Mac Mini on 5/10/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Cocoa
import CoreGraphics

class Chart: NSView {

    override var isFlipped: Bool { return true } // Flip coord system
    
    struct Ticker {
        var symbol = "?"
        var open   = 0.0
        var close  = 0.0
        var low    = 0.0
        var high   = 0.0
        var volume = 0
        var time   = 0
    }
    
    var ticker = [Ticker]() // This is the data we use to draw the candles

    struct Color {
        static let red   = CGColor(red: 0.7, green: 0,   blue: 0,   alpha: 1.0)
        static let green = CGColor(red: 0,   green: 0.7, blue: 0,   alpha: 1.0)
        static let blue  = CGColor(red: 0,   green: 0,   blue: 0.5, alpha: 1.0)
        static let gray  = CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    }
    
    struct Area {
        var width   = 1000
        var height  =  400
        var padding =   20
        var ratio   =    2.5
    }
    
    struct AxisX {
        var length  =  900
        var base    =  350
        var ticks   =   24
        var lower   =  340
    }
    
    struct AxisY {
        var length  =  300
        var base    =   50
        var ticks   =   10
        var ratio   =    1.0
    }
    
    var area  = Area()
    var axisX = AxisX()
    var axisY = AxisY()

    
    func clear() {
        //NSColor.white.setFill()
        let canvas = NSColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        canvas.setFill()
        NSRectFill(bounds)
    }

    func reset() {
        area.width   = Int(bounds.width)
        area.height  = Int(bounds.height)
        area.padding = Int(area.width / 20)
        axisX.length = area.width  - area.padding * 2
        axisY.length = area.height - area.padding * 2
        axisX.base   = area.height - area.padding
        axisY.base   = area.padding
        //Swift.print("W: \(area.width) H: \(area.height)")
    }
    
    // Data table should be ['symbol', open, close, low, high, volume, timestamp]
    // Here it will be converted to a ticker: [dictionary]
    func useData(_ table: [[Any]]) {
        ticker = [Ticker]()
        for item in table {
            ticker.append(Ticker(
                symbol : item[0] as! String,
                open   : item[1] as! Double,
                close  : item[2] as! Double,
                low    : item[3] as! Double,
                high   : item[4] as! Double,
                volume : item[5] as! Int,
                time   : item[6] as! Int
            ))
        }
    }
    
    func drawAxis() {
        let axisX_x1 = area.padding
        let axisX_y1 = area.height - area.padding
        let axisX_x2 = area.width  - area.padding
        let axisX_y2 = area.height - area.padding
        
        let axisY_x1 = area.padding
        let axisY_y1 = area.padding
        let axisY_x2 = area.padding
        let axisY_y2 = area.height - area.padding
        
        let context = NSGraphicsContext.current()?.cgContext

        context?.line(axisX_x1, axisX_y1, axisX_x2, axisX_y2, lineColor: Color.gray)
        context?.line(axisY_x1, axisY_y1, axisY_x2, axisY_y2, lineColor: Color.gray)
        
        // X Axis ticks
        var n = axisX.ticks
        var x = axisY.base
        var y = axisX.base
        var step = Int(axisX.length / (n + 1))
        
        for _ in 0..<n {
            x = x + step
            context?.line(x, axisX.base - 4, x, axisX.base + 4, lineColor: Color.gray)
        }
        
        // Y Axis ticks
        n = axisY.ticks
        step = Int(axisY.length / (n + 1))
        
        for _ in 0..<n {
            y = y - step
            context?.line(axisY.base - 4, y, axisY.base + 4, y, lineColor: Color.gray)
        }
    }

    func axisRatio() {
        var maxHi =   0.0
        var minLo = 999.0
        
        for item in ticker {
            maxHi = max(item.high, maxHi)
            minLo = min(item.low,  minLo)
        }
        //Swift.print(maxHi, minLo)
        
        let diff = maxHi - minLo
        let d10  = diff / 10
        //Swift.print(diff, d10)

        let tot = diff + d10 + d10
        let limitLo = minLo - d10
        //let limitHi = maxHi + d10
        axisX.lower = Int(limitLo)
        axisY.ratio = Double(axisY.length) / tot
        //Swift.print(limitLo, limitHi, tot, axisY.ratio)
    }
    
    func drawChart() {
        let step = Int(axisX.length / (axisX.ticks + 1))
        var color = Color.red
        let candleWidth = 6
        let candleHalf  = 3
        var shadowX1 = axisY.base
        var shadowX2 = axisY.base
        var candleX1 = 0
        //var candleX2 = 0
        var s1 = 0
        var s2 = 0
        var c1 = 0
        var c2 = 0
        
        for price in ticker {
            shadowX1 += step
            shadowX2 += step
            candleX1 = shadowX1 - candleHalf
            //candleX2 = shadowX2 + candleHalf

            if (price.open > price.close) {
                color = Color.red
                s1 = Int(Double(axisX.base) - ((price.low   - Double(axisX.lower)) * axisY.ratio))
                s2 = Int(Double(axisX.base) - ((price.high  - Double(axisX.lower)) * axisY.ratio))
                c1 = Int(Double(axisX.base) - ((price.open  - Double(axisX.lower)) * axisY.ratio))
                c2 = Int((price.open - price.close) * Double(axisY.ratio))
            } else {
                color = Color.green
                s1 = Int(Double(axisX.base) - ((price.low   - Double(axisX.lower)) * axisY.ratio))
                s2 = Int(Double(axisX.base) - ((price.high  - Double(axisX.lower)) * axisY.ratio))
                c1 = Int(Double(axisX.base) - ((price.close - Double(axisX.lower)) * axisY.ratio))
                c2 = Int((price.close - price.open) * Double(axisY.ratio))
            }
            //Swift.print(price.low, price.high, price.open, price.close, '-', s1, s2, c1, c2)
            //Swift.print(candleX1, c1, c2)
            let context = NSGraphicsContext.current()?.cgContext
            context?.line(shadowX1, s1, shadowX2, s2, lineColor: color) // shadow
            context?.rect(candleX1, c1, candleWidth, c2, borderColor: color, fillColor: color)  // candle
            
        }
        
        needsDisplay = true
    }
    
    func candlestick() {
        Swift.print("Candlestick")
        reset()
        clear()
        drawAxis()
        axisRatio()
        drawChart()
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        candlestick()
    }
    
}


// End
