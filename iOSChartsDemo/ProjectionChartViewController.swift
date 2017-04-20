import UIKit
import Charts

class ProjectionChartViewController: UIViewController {
    
    @IBOutlet weak var projectionChartView: LineChartView!
    
    func setProjectionChart(projection: Projection, goal: Goal){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

class Projection{
    
    let DEFAULT_PROJECTION = [95, 90, 70, 50, 30, 10, 5]
    let DEFAULT_PROJECTION_QUERY = "95,90,70,50,30,10,5"
    
    var startYear : Int?
    
    //List of bands
    var bands : [Band]?
    var targetAnnualIncome : Int?
    var targetMonthlyIncome: Int?
    var targetLumpSum: Int?
    var chanceOfSuccess: Float?
    var splitBand: Band?
    
    public func getChanceOfSuccess() -> Int {
        //Need to modify
        //If chance of success is null should return zero, else it should return chance of success
        return Int(round((chanceOfSuccess)!))
    }
    
    public func getLumpSumValue() -> Int {
        //also needs to return 0 if null
        return targetLumpSum!
    }
    
    public func getSplitBand() -> Band {
        return splitBand!
    }
    
    public func setSplitBand(band: Band){
        splitBand = band
    }
    
    func generateSplitBand() -> Band{
        var band = Band()
        var chanceOfSucess = getChanceOfSuccess()
        //var nearestProjectionBand =
        return band
    }
    
    func findNearesNumber(defaultProjection:[Int], number: Int) -> Int{
        var differenceList = [Int]()
        for i in 0..<defaultProjection.count{
            var diff = abs(defaultProjection[i] - number)
            differenceList.append(diff)
        }
        var minDiff = differenceList.min()
        var closestIndex = differenceList.index(of: minDiff)
        return defaultProjection[closestIndex]
    }
    
}

class Band {
    var percentile :Int?
    var value : [Float]?
}

class Goal{
    
}
