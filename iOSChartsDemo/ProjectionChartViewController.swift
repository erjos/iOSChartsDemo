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
        let band = Band()
        let chanceOfSucess = getChanceOfSuccess()
        let nearestProjectionBand = findNearesNumber(defaultProjection: DEFAULT_PROJECTION, number: chanceOfSucess)
        let bandIndex = DEFAULT_PROJECTION.index(of: nearestProjectionBand)
        let lowBand = bands?[bandIndex!]
        let highBand = bands?[bandIndex!+1]
        var value = [Float]()
        for i in 0..<(lowBand?.value?.count)!{
            let lowValue = lowBand?.value?[i]
            let highValue = highBand?.value?[i]
            let diff = (lowValue! + highValue!) / 2
            value.append(diff)
        }
        band.percentile = 100 - getChanceOfSuccess()
        band.value = value
        return band
    }
    
    func findNearesNumber(defaultProjection:[Int], number: Int) -> Int{
        var differenceList = [Int]()
        for i in 0..<defaultProjection.count{
            let diff = abs(defaultProjection[i] - number)
            differenceList.append(diff)
        }
        let minDiff = differenceList.min()
        let closestIndex = differenceList.index(of: minDiff!)
        return defaultProjection[closestIndex!]
    }
    
}

class Band {
    var percentile :Int?
    var value : [Float]?
}

class Goal{
    
}
