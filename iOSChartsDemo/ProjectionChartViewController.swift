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
    
    public var startYear : Int?
    //List of bands
    public var bands : [Band]?
    public var targetAnnualIncome : Int?
    public var targetMonthlyIncome: Int?
    public var targetLumpSum: Int?
    public var chanceOfSuccess: Float?
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
    public var percentile :Int?
    public var value : [Float]?
}

class Goal{
    public var id : Int?
    public var type: GoalType?
    public var name: String?
    public var associatedAccount: String?
    public var timeHorizon: Int?
    public var initialInvestmentAmount: Int?
    public var significantWithdrawalsBeforeTargetDate: Bool?
    public var informationAccuracyAck: Bool?
    public var overallRiskTolerance: Int?
    public var monthlyDeposit: Int?
    public var liquidNetWorth: Int?
    public var target: Target?
    public var monthsOfEmergencyFunds: Int?
    public var incomeRange: String?
    public var employmentStatus: String?
    
    enum GoalType : String{
        case Retirement = "Retirement"
        case Wealth = "Wealth"
        case Education = "Education"
        case Other = "Other"
    }
    
    class Target {
        public var targetType: TargetType?
        var value: Int?
        var targetDate: String?
        var yearsForMoneyToLast: Int?
        
        public func getYearsForMoneyToLast() -> Int{
            //add null check
            return yearsForMoneyToLast!
        }
        
        public func getDate() -> Date {
            return DateFormatter().date(from: targetDate!)!
        }
        
        public func getYearsToGoal() -> Int {
            //need to verify that this calculation is accurate
            let dateTarget = getDate()
            let dateCurrent = Date()
            let calendar = Calendar.current
            let yearTarget = calendar.component(.year, from: dateTarget)
            let yearCurrent = calendar.component(.year, from: dateCurrent)
            return yearTarget-yearCurrent
        }
        
        public func getTargetType() -> String {
                if (targetType?.rawValue == "Monthly"){
                    return "monthly"
                }
                if (targetType?.rawValue == "Annual"){
                    return "annual"
                }
                if (targetType?.rawValue == "LumpSum"){
                    return "lump-sum"
                }
                return ""
        }
        
        public func getTargetTypeInterval() -> String{
            if (targetType?.rawValue == "Monthly"){
                return "month"
            } else if (targetType?.rawValue == "Annual"){
                return "year"
            } else {
                return ""
            }
        }
        
        public func getTargetAmount() -> String {
            //format value as currency String
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            return formatter.string(from: value! as NSNumber)!
        }
        
        public func getTargetValue() -> Int {
            return value!
        }
        
        enum TargetType: String {
            case Monthly = "Monthly"
            case Annual = "Annual"
            case LumpSum = "LumpSum"
        }
    }
}



