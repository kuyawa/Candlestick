//
//  ViewController.swift
//  Candlestick
//
//  Created by Mac Mini on 5/10/17.
//  Copyright © 2017 Armonia. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var chart: Chart!
    
    // Sample data
    var table = [
        ["AAPL", 125.0, 132.0, 118.0, 136.0, 999, 1234567890],
        ["AAPL", 128.0, 136.0, 124.0, 144.0, 999, 1234567890],
        ["AAPL", 134.0, 132.0, 128.0, 138.0, 999, 1234567890],
        ["AAPL", 129.0, 127.0, 124.0, 132.0, 999, 1234567890],
        ["AAPL", 122.0, 115.0, 110.0, 122.0, 999, 1234567890],
        ["AAPL", 116.0, 118.0, 112.0, 118.0, 999, 1234567890],
        ["AAPL", 124.0, 122.0, 118.0, 128.0, 999, 1234567890],
        ["AAPL", 120.0, 125.0, 119.0, 126.0, 999, 1234567890],
        ["AAPL", 118.0, 120.0, 116.0, 125.0, 999, 1234567890],
        ["AAPL", 129.0, 127.0, 124.0, 132.0, 999, 1234567890],
        ["AAPL", 124.0, 136.0, 122.0, 138.0, 999, 1234567890],
        ["AAPL", 124.0, 128.0, 120.0, 130.0, 999, 1234567890],
        ["AAPL", 125.0, 132.0, 118.0, 136.0, 999, 1234567890],
        ["AAPL", 134.0, 132.0, 128.0, 138.0, 999, 1234567890],
        ["AAPL", 128.0, 136.0, 124.0, 144.0, 999, 1234567890],
        ["AAPL", 120.0, 125.0, 119.0, 126.0, 999, 1234567890],
        ["AAPL", 124.0, 122.0, 118.0, 128.0, 999, 1234567890],
        ["AAPL", 116.0, 118.0, 112.0, 118.0, 999, 1234567890],
        ["AAPL", 124.0, 128.0, 120.0, 130.0, 999, 1234567890],
        ["AAPL", 124.0, 122.0, 118.0, 128.0, 999, 1234567890],
        ["AAPL", 122.0, 115.0, 110.0, 122.0, 999, 1234567890],
        ["AAPL", 118.0, 120.0, 116.0, 125.0, 999, 1234567890],
        ["AAPL", 118.0, 120.0, 116.0, 125.0, 999, 1234567890],
        ["AAPL", 120.0, 125.0, 119.0, 126.0, 999, 1234567890]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.useData(table)
        chart.display()
    }

}

