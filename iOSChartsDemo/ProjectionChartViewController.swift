import UIKit
import Charts
import SwiftyJSON

class ProjectionChartViewController: UIViewController {
    
    @IBOutlet weak var projectionChartView: LineChartView!
    
    var projectionString : String?
    
    func setProjectionChart(projection: Projection, goal: Goal){
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        projectionString = "{\"targetAnnualIncome\":null,\"startYear\":2016,\"isCurrentDollars\":true,\"bands\":[{\"percentile\":5,\"value\":[21223.071,21240.326571,20556.741981,21794.030241,22371.650895,22729.501234,23799.499513,23067.337084,24501.951792,25265.684211,26683.946455,26643.735893,26332.375831,29401.373277,30630.24683,32305.639077,32572.051165,32913.046886,36413.65465,37738.824872,39749.523055,41191.361405,41565.671905,43909.532747,44850.440552,46567.89654,47886.586539,47147.180357,0.0]},{\"percentile\":30,\"value\":[25256.45925,26222.428279,27617.450431,29351.831725,31114.914454,32480.694073,33983.122832,36130.967598,38133.663583,40148.904567,43259.178595,45379.51216,46719.16989,49634.935014,51433.145012,54839.971431,58427.050807,61567.505169,65432.451111,70502.111229,75014.496307,76880.101335,79533.171057,84213.342872,90012.150065,95821.632859,102856.272249,106957.519343,0.0]},{\"percentile\":50,\"value\":[26761.47325,28902.325185,31457.984437,33832.546863,35710.206463,38090.857872,40082.582694,43138.127444,44948.549802,47815.376304,53065.276308,56996.387252,59918.480504,64272.936456,66700.962056,69363.425749,73595.917583,78627.723103,84623.68198,90473.558356,95000.567228,102681.521907,105738.048873,112967.830457,117637.264195,123675.013215,131002.44484,141140.801294,0.0]},{\"percentile\":70,\"value\":[28593.2535,31525.034422,34865.474082,38191.999438,41204.684108,44429.715231,48618.349901,51599.865044,55243.340398,59903.057595,63257.952105,68744.909923,74630.94953,79429.404683,84787.245052,89183.455399,96141.78855,105148.214452,113810.916986,118704.942888,126365.95237,130752.713211,135457.911666,142439.158689,154635.136871,170200.815315,178851.222955,189138.051419,35369.950914]},{\"percentile\":90,\"value\":[31219.53925,34810.701518,39878.564684,45093.695967,49127.959075,54715.501433,60610.173,67566.109309,72912.153104,78710.162807,86811.885866,91463.491776,101068.118838,110943.303886,125663.641797,133028.285078,140157.765426,151279.268943,159602.728984,170899.177534,187225.644715,192167.317931,209599.31803,226727.864363,248375.11369,264656.690651,278052.791607,306082.028793,161555.251931]},{\"percentile\":95,\"value\":[32339.319,37214.932394,43206.500875,48738.848734,53187.226764,61022.77589,68122.621101,76980.478987,82689.281467,93833.539008,101853.005098,106952.519446,118803.779646,127103.389403,142658.595778,148911.169626,159697.029163,179229.004515,187767.528965,200957.053636,211054.807043,230039.582222,258068.697346,278780.087046,310574.364388,326333.040525,353825.85326,359885.116668,221075.297922]}],\"targetLumpSum\":157000,\"targetMonthlyIncome\":null,\"chanceOfSuccess\":26.5}"
        
        let json = JSON(parseJSON: projectionString!)
        
        let projection = Projection.init(json: json)

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
    
    public init(json: JSON){
        startYear = json["startYear"].intValue
        
        //I don't think this will work, but will test later
        //bands = json["bands"].arrayObject as? [Band]
        
        //array of json objects
        var jsonArrayBands = json["bands"].array
        
        //empty array of bands
        var actualBands = [Band]()

        //create list of bands - is there a better for loop?
        for i in 0..<(jsonArrayBands?.count)!{
            //create actual band object
            let band = Band.init(json:jsonArrayBands?[i])
            //add to array of bands
            actualBands.append(band)
        }
        
        bands = actualBands
        
        targetAnnualIncome = json["targetAnnualIncome"].intValue
        targetMonthlyIncome = json["targetMonthlyIncome"].intValue
        targetLumpSum = json["targetLumpSum"].intValue
        chanceOfSuccess = json["chanceOfSuccess"].floatValue
        
    }
    
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
    
    public init(json: JSON? = nil){
        percentile = json?["percentile"].intValue
        
        //this also might not work
        value = json?["value"].arrayObject as! [Float]?
    }
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



