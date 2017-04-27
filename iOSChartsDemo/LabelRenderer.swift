//
//  LabelRenderer.swift
//  iOSChartsDemo
//
//  Created by Joseph, Ethan on 4/26/17.
//  Copyright © 2017 Appcoda. All rights reserved.
//

import Foundation
import CoreGraphics
import Charts

//@objc(ChartYAxisRenderer)
open class LabelRenderer: YAxisRenderer
{
    private let entries : [Double]
    
    public init(viewPortHandler: ViewPortHandler?, yAxis: YAxis?, transformer: Transformer?, entries: [Double])
    {
        self.entries = entries
        super.init(viewPortHandler: viewPortHandler, yAxis: yAxis, transformer: transformer)
    }
    
    override open func computeAxisValues(min: Double, max: Double) {
        let axis = self.axis
        axis?.entries = entries
        
        //shouldn't need to set entry count since it returns from the entries
    }
    
    /// draws the y-axis labels to the screen
    open override func renderAxisLabels(context: CGContext)
    {
        guard
            let yAxis = self.axis as? YAxis,
            let viewPortHandler = self.viewPortHandler
            else { return }
        
        if !yAxis.isEnabled || !yAxis.isDrawLabelsEnabled
        {
            return
        }
        
        let xoffset = yAxis.xOffset
        let yoffset = yAxis.labelFont.lineHeight / 2.5 + yAxis.yOffset
        
        let dependency = yAxis.axisDependency
        let labelPosition = yAxis.labelPosition
        
        //mine
        var xPos  = viewPortHandler.contentRight
        
        var textAlign: NSTextAlignment
        
        if dependency == .left
        {
            if labelPosition == .outsideChart
            {
                textAlign = .right
                xPos = viewPortHandler.offsetLeft - xoffset
            }
            else
            {
                textAlign = .left
                xPos = viewPortHandler.offsetLeft + xoffset
            }
            
        }
        else
        {
            if labelPosition == .outsideChart
            {
                textAlign = .left
                xPos = viewPortHandler.contentRight + xoffset
            }
            else
            {
                textAlign = .right
                xPos = viewPortHandler.contentRight - xoffset
            }
        }
        
        drawYLabelsPublic(
            context: context,
            fixedPosition: xPos,
            positions: transformedPositions(),
            offset: yoffset, //yoffset - yAxis.labelFont.lineHeight,
            textAlign: textAlign)
        }
    
    open override func renderAxisLine(context: CGContext)
    {
        guard
            let yAxis = self.axis as? YAxis,
            let viewPortHandler = self.viewPortHandler
            else { return }
        
        if !yAxis.isEnabled || !yAxis.drawAxisLineEnabled
        {
            return
        }
        
        context.saveGState()
        
        context.setStrokeColor(yAxis.axisLineColor.cgColor)
        context.setLineWidth(yAxis.axisLineWidth)
        if yAxis.axisLineDashLengths != nil
        {
            context.setLineDash(phase: yAxis.axisLineDashPhase, lengths: yAxis.axisLineDashLengths)
        }
        else
        {
            context.setLineDash(phase: 0.0, lengths: [])
        }
        
        if yAxis.axisDependency == .left
        {
            context.beginPath()
            context.move(to: CGPoint(x: viewPortHandler.contentLeft, y: viewPortHandler.contentTop))
            context.addLine(to: CGPoint(x: viewPortHandler.contentLeft, y: viewPortHandler.contentBottom))
            context.strokePath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(x: viewPortHandler.contentRight, y: viewPortHandler.contentTop))
            context.addLine(to: CGPoint(x: viewPortHandler.contentRight, y: viewPortHandler.contentBottom))
            context.strokePath()
        }
        
        context.restoreGState()
    }
    
    /// draws the y-labels on the specified x-position
    public func drawYLabelsPublic(
        context: CGContext,
        fixedPosition: CGFloat,
        positions: [CGPoint],
        offset: CGFloat,
        textAlign: NSTextAlignment)
    {
        guard
            let yAxis = self.axis as? YAxis
            else { return }
        
        let labelFont = yAxis.labelFont
        
        //let labelTextColor = yAxis.labelTextColor
        let labelTextColor = UIColor.white
        
        let from = yAxis.isDrawBottomYLabelEntryEnabled ? 0 : 1
        let to = yAxis.isDrawTopYLabelEntryEnabled ? yAxis.entryCount : (yAxis.entryCount - 1)
        
        for i in stride(from: from, to: to, by: 1)
        {
            //This is the label that the formatter we need to create will return
            let text = yAxis.getFormattedLabel(i)
            
            let image = #imageLiteral(resourceName: "y-axis-bubble")
            
            let size = CGSize(width: 50.0, height: 20.0)
            
            //there's this draw Image thing n b
            ChartUtils.drawImage(context: context, image: image, x: fixedPosition + 25, y: (positions[i].y + offset)-5, size: size)
            
            ChartUtils.drawText(
                context: context,
                text: text,
                point: CGPoint(x: fixedPosition + 10, y: (positions[i].y) - 5),//+ offset),
                align: textAlign,
                attributes: [NSFontAttributeName: labelFont, NSForegroundColorAttributeName: labelTextColor])
        }
    }
    
    open override func renderGridLines(context: CGContext)
    {
        guard let
            yAxis = self.axis as? YAxis
            else { return }
        
        if !yAxis.isEnabled
        {
            return
        }
        
        if yAxis.drawGridLinesEnabled
        {
            let positions = transformedPositions()
            
            context.saveGState()
            defer { context.restoreGState() }
            context.clip(to: self.gridClippingRect)
            
            context.setShouldAntialias(yAxis.gridAntialiasEnabled)
            context.setStrokeColor(yAxis.gridColor.cgColor)
            context.setLineWidth(yAxis.gridLineWidth)
            context.setLineCap(yAxis.gridLineCap)
            
            if yAxis.gridLineDashLengths != nil
            {
                context.setLineDash(phase: yAxis.gridLineDashPhase, lengths: yAxis.gridLineDashLengths)
                
            }
            else
            {
                context.setLineDash(phase: 0.0, lengths: [])
            }
            
            // draw the grid
            for i in 0 ..< positions.count
            {
                drawGridLine(context: context, position: positions[i])
            }
        }
        
        if yAxis.drawZeroLineEnabled
        {
            // draw zero line
            drawZeroLine(context: context)
        }
    }
    
    open override func renderLimitLines(context: CGContext)
    {
        guard
            let yAxis = self.axis as? YAxis,
            let viewPortHandler = self.viewPortHandler,
            let transformer = self.transformer
            else { return }
        
        var limitLines = yAxis.limitLines
        
        if limitLines.count == 0
        {
            return
        }
        
        context.saveGState()
        
        let trans = transformer.valueToPixelMatrix
        
        var position = CGPoint(x: 0.0, y: 0.0)
        
        for i in 0 ..< limitLines.count
        {
            let l = limitLines[i]
            
            if !l.isEnabled
            {
                continue
            }
            
            context.saveGState()
            defer { context.restoreGState() }
            
            var clippingRect = viewPortHandler.contentRect
            clippingRect.origin.y -= l.lineWidth / 2.0
            clippingRect.size.height += l.lineWidth
            context.clip(to: clippingRect)
            
            position.x = 0.0
            position.y = CGFloat(l.limit)
            position = position.applying(trans)
            
            context.beginPath()
            context.move(to: CGPoint(x: viewPortHandler.contentLeft, y: position.y))
            context.addLine(to: CGPoint(x: viewPortHandler.contentRight, y: position.y))
            
            context.setStrokeColor(l.lineColor.cgColor)
            context.setLineWidth(l.lineWidth)
            if l.lineDashLengths != nil
            {
                context.setLineDash(phase: l.lineDashPhase, lengths: l.lineDashLengths!)
            }
            else
            {
                context.setLineDash(phase: 0.0, lengths: [])
            }
            
            context.strokePath()
            
            let label = l.label
            
            // if drawing the limit-value label is enabled
            if l.drawLabelEnabled && label.characters.count > 0
            {
                let labelLineHeight = l.valueFont.lineHeight
                
                let xOffset: CGFloat = 4.0 + l.xOffset
                let yOffset: CGFloat = l.lineWidth + labelLineHeight + l.yOffset
                
                if l.labelPosition == .rightTop
                {
                    ChartUtils.drawText(context: context,
                                        text: label,
                                        point: CGPoint(
                                            x: viewPortHandler.contentRight - xOffset,
                                            y: position.y - yOffset),
                                        align: .right,
                                        attributes: [NSFontAttributeName: l.valueFont, NSForegroundColorAttributeName: l.valueTextColor])
                }
                else if l.labelPosition == .rightBottom
                {
                    ChartUtils.drawText(context: context,
                                        text: label,
                                        point: CGPoint(
                                            x: viewPortHandler.contentRight - xOffset,
                                            y: position.y + yOffset - labelLineHeight),
                                        align: .right,
                                        attributes: [NSFontAttributeName: l.valueFont, NSForegroundColorAttributeName: l.valueTextColor])
                }
                else if l.labelPosition == .leftTop
                {
                    ChartUtils.drawText(context: context,
                                        text: label,
                                        point: CGPoint(
                                            x: viewPortHandler.contentLeft + xOffset,
                                            y: position.y - yOffset),
                                        align: .left,
                                        attributes: [NSFontAttributeName: l.valueFont, NSForegroundColorAttributeName: l.valueTextColor])
                }
                else
                {
                    ChartUtils.drawText(context: context,
                                        text: label,
                                        point: CGPoint(
                                            x: viewPortHandler.contentLeft + xOffset,
                                            y: position.y + yOffset - labelLineHeight),
                                        align: .left,
                                        attributes: [NSFontAttributeName: l.valueFont, NSForegroundColorAttributeName: l.valueTextColor])
                }
            }
        }
        
        context.restoreGState()
    }
}
