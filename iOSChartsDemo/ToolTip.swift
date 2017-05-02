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
        
        //NOTE: the offset for this is incorrect, I had the target marker line up for aesthetics, not for accuracy.
        //In production it should accurately reflect the accounts target amount
        self.offset = CGPoint(x: -140, y: -60)
        return offset
    }
}
