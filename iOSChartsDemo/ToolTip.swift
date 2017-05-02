//
//  ToolTip.swift
//  iOSChartsDemo
//
//  Created by Joseph, Ethan on 5/1/17.
//  Copyright © 2017 Appcoda. All rights reserved.
//
import UIKit
import Foundation
import Charts

class ToolTip : MarkerView{
    
    @IBOutlet weak var toolTipImageView: UIImageView!
    
    override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
        
        self.offset = CGPoint(x: -140, y: -60)
        return offset
    }
}
