//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    func setChart(dataPoints: [String], values: [Double]){
        
        //Label if data does not load
        barChartView.noDataText = "You need to provide data for the chart."
        
        var dataEntries: [BarChartDataEntry] = []
        
        //Build Entries
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        //Build Data Set
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Units Sold")
        chartDataSet.setColor(NSUIColor.green)
        
        //Build Data
        let chartData = BarChartData(dataSet: chartDataSet)
        
        //Set Chart Data
        barChartView.data = chartData
        
        //Axis Formatter
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mock Data
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(dataPoints: months, values: unitsSold)
    }
}

