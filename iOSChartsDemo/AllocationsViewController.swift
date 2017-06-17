import Foundation
import Charts
import SwiftyJSON

class AllocationsViewController: UIViewController {
    let color0 = NSUIColor(colorLiteralRed: 42/255, green: 132/255, blue: 236/255, alpha: 255/255)
    let color1 = NSUIColor(colorLiteralRed: 37/255, green: 119/255, blue: 212/255, alpha: 255/255)
    let color2 = NSUIColor(colorLiteralRed: 29/255, green: 92/255, blue: 164/255, alpha: 255/255)
    let color3 = NSUIColor(colorLiteralRed: 0/255, green: 120/255, blue: 150/255, alpha: 255/255)
    let color4 = NSUIColor(colorLiteralRed: 0/255, green: 154/255, blue: 193/255, alpha: 255/255)
    let color5 = NSUIColor(colorLiteralRed: 0/255, green: 172/255, blue: 215/255, alpha: 255/255)
    let color6 = NSUIColor(colorLiteralRed: 76/255, green: 196/255, blue: 226/255, alpha: 255/255)
    let color7 = NSUIColor(colorLiteralRed: 178/255, green: 229/255, blue: 242/255, alpha: 255/255)
    let color8 = NSUIColor(colorLiteralRed: 210/255, green: 198/255, blue: 235/255, alpha: 255/255)
    let color9 = NSUIColor(colorLiteralRed: 183/255, green: 163/255, blue: 235/255, alpha: 222/255)
    let color10 = NSUIColor(colorLiteralRed: 152/255, green: 124/255, blue: 209/255, alpha: 222/255)
    let color11 = NSUIColor(colorLiteralRed: 122/255, green: 87/255, blue: 196/255, alpha: 222/255)
    let color12 = NSUIColor(colorLiteralRed: 108/255, green: 68/255, blue: 190/255, alpha: 222/255)
    
    var portfolioBreakdown: PortfolioBreakdown!
    
    
    
    let JsonString = "{\"netAssetAllocation\":{\"categoryTitle\":\"Asset Classes\",\"entryTitle\":\"Asset Class\",\"totalAmount\":{\"value\":26926.05,\"formattedValue\":\"$26,926.05\"},\"portfolioBreakdowns\":[{\"name\":\"Fixed Income\",\"shortName\":\"Fixed Income\",\"percentage\":{\"value\":77.69,\"formattedValue\":\"77.69%\"},\"amount\":{\"value\":20918.848,\"formattedValue\":\"$20,918.85\"}},{\"name\":\"Domestic Equities\",\"shortName\":\"Domestic Equities\",\"percentage\":{\"value\":9.869,\"formattedValue\":\"9.87%\"},\"amount\":{\"value\":2657.3318,\"formattedValue\":\"$2,657.33\"}},{\"name\":\"International Equities\",\"shortName\":\"International Equities\",\"percentage\":{\"value\":8.4876,\"formattedValue\":\"8.49%\"},\"amount\":{\"value\":2285.3755,\"formattedValue\":\"$2,285.38\"}},{\"name\":\"Other\",\"shortName\":\"Other\",\"percentage\":{\"value\":3.6316,\"formattedValue\":\"3.63%\"},\"amount\":{\"value\":977.8464,\"formattedValue\":\"$977.85\"}},{\"name\":\"Cash\",\"shortName\":\"Cash\",\"percentage\":{\"value\":0.3218,\"formattedValue\":\"0.32%\"},\"amount\":{\"value\":86.648,\"formattedValue\":\"$86.65\"}},{\"name\":\"Not Classified\",\"shortName\":\"Not Classified\",\"percentage\":{\"value\":0,\"formattedValue\":\"0.00%\"},\"amount\":{\"value\":0,\"formattedValue\":\"$0.00\"}}]},\"sectors\":{\"categoryTitle\":\"Sectors\",\"entryTitle\":\"Sector\",\"totalAmount\":{\"value\":4942.7075,\"formattedValue\":\"$4,942.71\"},\"portfolioBreakdowns\":[{\"name\":\"Financials\",\"shortName\":\"Financials\",\"percentage\":{\"value\":14.459,\"formattedValue\":\"14.46%\"},\"amount\":{\"value\":714.666,\"formattedValue\":\"$714.67\"}},{\"name\":\"Health Care\",\"shortName\":\"Health Care\",\"percentage\":{\"value\":13.832,\"formattedValue\":\"13.83%\"},\"amount\":{\"value\":683.6753,\"formattedValue\":\"$683.68\"}},{\"name\":\"Consumer Staples\",\"shortName\":\"Consumer Staples\",\"percentage\":{\"value\":11.012,\"formattedValue\":\"11.01%\"},\"amount\":{\"value\":544.2909,\"formattedValue\":\"$544.29\"}},{\"name\":\"Information Technology\",\"shortName\":\"Information Technology\",\"percentage\":{\"value\":10.8195,\"formattedValue\":\"10.82%\"},\"amount\":{\"value\":534.7762,\"formattedValue\":\"$534.78\"}},{\"name\":\"Real Estate\",\"shortName\":\"Real Estate\",\"percentage\":{\"value\":9.6138,\"formattedValue\":\"9.61%\"},\"amount\":{\"value\":475.182,\"formattedValue\":\"$475.18\"}},{\"name\":\"Consumer Discretionary\",\"shortName\":\"Consumer Discretionary\",\"percentage\":{\"value\":9.1562,\"formattedValue\":\"9.16%\"},\"amount\":{\"value\":452.5642,\"formattedValue\":\"$452.56\"}},{\"name\":\"Energy\",\"shortName\":\"Energy\",\"percentage\":{\"value\":7.9716,\"formattedValue\":\"7.97%\"},\"amount\":{\"value\":394.0129,\"formattedValue\":\"$394.01\"}},{\"name\":\"Industrials\",\"shortName\":\"Industrials\",\"percentage\":{\"value\":7.03,\"formattedValue\":\"7.03%\"},\"amount\":{\"value\":347.4723,\"formattedValue\":\"$347.47\"}},{\"name\":\"Materials\",\"shortName\":\"Materials\",\"percentage\":{\"value\":6.2756,\"formattedValue\":\"6.28%\"},\"amount\":{\"value\":310.1845,\"formattedValue\":\"$310.18\"}},{\"name\":\"Telecommunication Services\",\"shortName\":\"Telecommunication Services\",\"percentage\":{\"value\":5.4267,\"formattedValue\":\"5.43%\"},\"amount\":{\"value\":268.2259,\"formattedValue\":\"$268.23\"}},{\"name\":\"Utilities\",\"shortName\":\"Utilities\",\"percentage\":{\"value\":4.4016,\"formattedValue\":\"4.40%\"},\"amount\":{\"value\":217.5582,\"formattedValue\":\"$217.56\"}},{\"name\":\"Not Classified\",\"shortName\":\"Not Classified\",\"percentage\":{\"value\":0.0019,\"formattedValue\":\"0.00%\"},\"amount\":{\"value\":0.0939,\"formattedValue\":\"$0.09\"}}]},\"positions\":{\"categoryTitle\":\"Holdings\",\"entryTitle\":\"Holding\",\"totalAmount\":{\"value\":26926.05,\"formattedValue\":\"$26,926.05\"},\"portfolioBreakdowns\":[{\"name\":\"BlackRock Total Return K\",\"shortName\":\"MPHQX\",\"percentage\":{\"value\":15.9914,\"formattedValue\":\"15.99%\"},\"amount\":{\"value\":4305.85,\"formattedValue\":\"$4,305.85\"}},{\"name\":\"Metropolitan West Total Return Bd Plan\",\"shortName\":\"MWTSX\",\"percentage\":{\"value\":11.9569,\"formattedValue\":\"11.96%\"},\"amount\":{\"value\":3219.52,\"formattedValue\":\"$3,219.52\"}},{\"name\":\"DoubleLine Low Duration Bond I\",\"shortName\":\"DBLSX\",\"percentage\":{\"value\":7.9522,\"formattedValue\":\"7.95%\"},\"amount\":{\"value\":2141.21,\"formattedValue\":\"$2,141.21\"}},{\"name\":\"PIMCO Income Instl\",\"shortName\":\"PIMIX\",\"percentage\":{\"value\":6.9932,\"formattedValue\":\"6.99%\"},\"amount\":{\"value\":1882.98,\"formattedValue\":\"$1,882.98\"}},{\"name\":\"Janus Henderson Flexible Bond T\",\"shortName\":\"JAFIX\",\"percentage\":{\"value\":6.9811,\"formattedValue\":\"6.98%\"},\"amount\":{\"value\":1879.73,\"formattedValue\":\"$1,879.73\"}},{\"name\":\"T. Rowe Price Instl Floating Rate\",\"shortName\":\"RPIFX\",\"percentage\":{\"value\":6.9276,\"formattedValue\":\"6.93%\"},\"amount\":{\"value\":1865.34,\"formattedValue\":\"$1,865.34\"}},{\"name\":\"Touchstone Premium Yield Equity Y\",\"shortName\":\"TPYYX\",\"percentage\":{\"value\":6.044,\"formattedValue\":\"6.04%\"},\"amount\":{\"value\":1627.42,\"formattedValue\":\"$1,627.42\"}},{\"name\":\"Franklin Mutual Quest Z\",\"shortName\":\"MQIFX\",\"percentage\":{\"value\":6.0178,\"formattedValue\":\"6.02%\"},\"amount\":{\"value\":1620.36,\"formattedValue\":\"$1,620.36\"}},{\"name\":\"TCW Emerging Markets Income I\",\"shortName\":\"TGEIX\",\"percentage\":{\"value\":5.9492,\"formattedValue\":\"5.95%\"},\"amount\":{\"value\":1601.89,\"formattedValue\":\"$1,601.89\"}},{\"name\":\"Morgan Stanley Inst International Eq I\",\"shortName\":\"MSIQX\",\"percentage\":{\"value\":5.1023,\"formattedValue\":\"5.10%\"},\"amount\":{\"value\":1373.84,\"formattedValue\":\"$1,373.84\"}},{\"name\":\"Loomis Sayles Bond N\",\"shortName\":\"LSBNX\",\"percentage\":{\"value\":5.0181,\"formattedValue\":\"5.02%\"},\"amount\":{\"value\":1351.18,\"formattedValue\":\"$1,351.18\"}},{\"name\":\"BlackRock Multi-Asset Income Portfolio K\",\"shortName\":\"BKMIX\",\"percentage\":{\"value\":4.9595,\"formattedValue\":\"4.96%\"},\"amount\":{\"value\":1335.41,\"formattedValue\":\"$1,335.41\"}},{\"name\":\"Neuberger Berman Equity Income Inst\",\"shortName\":\"NBHIX\",\"percentage\":{\"value\":3.0303,\"formattedValue\":\"3.03%\"},\"amount\":{\"value\":815.95,\"formattedValue\":\"$815.95\"}},{\"name\":\"PIMCO Real Return Instl\",\"shortName\":\"PRRIX\",\"percentage\":{\"value\":2.952,\"formattedValue\":\"2.95%\"},\"amount\":{\"value\":794.86,\"formattedValue\":\"$794.86\"}},{\"name\":\"Janus Henderson High-Yield T\",\"shortName\":\"JAHYX\",\"percentage\":{\"value\":1.9799,\"formattedValue\":\"1.98%\"},\"amount\":{\"value\":533.1,\"formattedValue\":\"$533.10\"}},{\"name\":\"CASH\",\"shortName\":\"cashCash\",\"percentage\":{\"value\":1.1416,\"formattedValue\":\"1.14%\"},\"amount\":{\"value\":307.39,\"formattedValue\":\"$307.39\"}},{\"name\":\"Invesco Global Real Estate Income Y\",\"shortName\":\"ASRYX\",\"percentage\":{\"value\":1.0028,\"formattedValue\":\"1.00%\"},\"amount\":{\"value\":270.02,\"formattedValue\":\"$270.02\"}}]},\"regions\":{\"categoryTitle\":\"Regions\",\"entryTitle\":\"Region\",\"totalAmount\":{\"value\":4942.7075,\"formattedValue\":\"$4,942.71\"},\"portfolioBreakdowns\":[{\"name\":\"Americas\",\"shortName\":\"Americas\",\"percentage\":{\"value\":58.89,\"formattedValue\":\"58.89%\"},\"amount\":{\"value\":2910.7603,\"formattedValue\":\"$2,910.76\"}},{\"name\":\"Greater Europe\",\"shortName\":\"Greater Europe\",\"percentage\":{\"value\":31.33,\"formattedValue\":\"31.33%\"},\"amount\":{\"value\":1548.5502,\"formattedValue\":\"$1,548.55\"}},{\"name\":\"Greater Asia\",\"shortName\":\"Greater Asia\",\"percentage\":{\"value\":9.78,\"formattedValue\":\"9.78%\"},\"amount\":{\"value\":483.3968,\"formattedValue\":\"$483.40\"}},{\"name\":\"Not Classified\",\"shortName\":\"Not Classified\",\"percentage\":{\"value\":0,\"formattedValue\":\"0.00%\"},\"amount\":{\"value\":0,\"formattedValue\":\"$0.00\"}}]},\"stockTypes\":{\"categoryTitle\":\"Types\",\"entryTitle\":\"Type\",\"totalAmount\":{\"value\":4942.7075,\"formattedValue\":\"$4,942.71\"},\"portfolioBreakdowns\":[{\"name\":\"Not Classified\",\"shortName\":\"Not Classified\",\"percentage\":{\"value\":41.1878,\"formattedValue\":\"41.19%\"},\"amount\":{\"value\":2035.7924,\"formattedValue\":\"$2,035.79\"}},{\"name\":\"Cyclical\",\"shortName\":\"Cyclical\",\"percentage\":{\"value\":21.9346,\"formattedValue\":\"21.93%\"},\"amount\":{\"value\":1084.1631,\"formattedValue\":\"$1,084.16\"}},{\"name\":\"Slow Growth\",\"shortName\":\"Slow Growth\",\"percentage\":{\"value\":13.1378,\"formattedValue\":\"13.14%\"},\"amount\":{\"value\":649.363,\"formattedValue\":\"$649.36\"}},{\"name\":\"Hard Asset\",\"shortName\":\"Hard Asset\",\"percentage\":{\"value\":11.4619,\"formattedValue\":\"11.46%\"},\"amount\":{\"value\":566.5282,\"formattedValue\":\"$566.53\"}},{\"name\":\"High Yield\",\"shortName\":\"High Yield\",\"percentage\":{\"value\":5.7687,\"formattedValue\":\"5.77%\"},\"amount\":{\"value\":285.13,\"formattedValue\":\"$285.13\"}},{\"name\":\"Classic Growth\",\"shortName\":\"Classic Growth\",\"percentage\":{\"value\":2.3723,\"formattedValue\":\"2.37%\"},\"amount\":{\"value\":117.2558,\"formattedValue\":\"$117.26\"}},{\"name\":\"Aggressive Growth\",\"shortName\":\"Aggressive Growth\",\"percentage\":{\"value\":2.1174,\"formattedValue\":\"2.12%\"},\"amount\":{\"value\":104.6569,\"formattedValue\":\"$104.66\"}},{\"name\":\"Distressed\",\"shortName\":\"Distressed\",\"percentage\":{\"value\":1.8324,\"formattedValue\":\"1.83%\"},\"amount\":{\"value\":90.5702,\"formattedValue\":\"$90.57\"}},{\"name\":\"Speculative Growth\",\"shortName\":\"Speculative Growth\",\"percentage\":{\"value\":0.1872,\"formattedValue\":\"0.19%\"},\"amount\":{\"value\":9.2527,\"formattedValue\":\"$9.25\"}}]}}\r\n"
    
    
    @IBOutlet weak var allocationsChartView: PieChartView!
    
    override func viewDidLoad() {
        
        let json = JSON.init(parseJSON: JsonString)
        
        portfolioBreakdown = PortfolioBreakdown.init(json: json)
        
        setAllocationsChart(portfolioBreakdown: portfolioBreakdown)
        
    }
    
    func setAllocationsChart(portfolioBreakdown: PortfolioBreakdown){
        
        var allocationsEntries = [PieChartDataEntry]()
        
        let breakdownCount = portfolioBreakdown.positions?.portfolioBreakdowns?.count
        
        let colorChoices = [color0, color1, color2, color3, color4, color5, color6, color7, color8, color9, color10, color11, color12]
        
        
        var colorsUsed = [NSUIColor]()
        var insertIndex = 0
        var counter = 0
        
        for i in 1..<breakdownCount! {
            
            var colorIndex = 1
            
            if(i <= 6){
                colorIndex = i * 2
                let color = colorChoices[colorIndex]
                colorsUsed.append(color)
            }
            
            if(i > 6 && i <= 12){
                colorIndex = (i - 6) + counter
                let color = colorChoices[colorIndex]
                colorsUsed.insert(color, at: insertIndex)
                counter += 1
                insertIndex += 2
            }
            
            //This adds color0 in at index 0 when there are enough breakdowns to mandate it, but I think it looks better without it - also would avoid having an odd number of colors
//            if(i == 12){
//                colorIndex = 0
//                let color = colorChoices[colorIndex]
//                colorsUsed.insert(color, at: 0)
//            }
        }
        
        for breakdown in (portfolioBreakdown.positions?.portfolioBreakdowns)!{
            //These entries can also be initialized with a label
            let entry = PieChartDataEntry(value: (breakdown.percentage?.value)!)
            allocationsEntries.append(entry)
        }
        
        //let arrayOfDataSet = [IChartDataSet]()
        
        let allocationsDataSet = PieChartDataSet(values: allocationsEntries, label: "chart")
        
        allocationsDataSet.sliceSpace = 1
        
        //TODO: use below to pass in the array of colors that we will use for the wheel
        allocationsDataSet.setColors(colorsUsed, alpha: 255/255)
        //allocationsDataSet.setColor(color1)
    
        //TODO: can also initialize the data with an array of dataSets *** I wonder what this does - check it out later
        let allocationsData = PieChartData(dataSet: allocationsDataSet)
        
        allocationsData.setDrawValues(false)
        
        allocationsChartView.data = allocationsData
        allocationsChartView.holeRadiusPercent = 165/255
    }
}

extension AllocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (portfolioBreakdown.positions?.portfolioBreakdowns?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension AllocationsViewController: UITableViewDelegate{
    
}

class PortfolioBreakdown {
    var netAssetAllocation: Category?
    var sectors: Category?
    var positions: Category?
    var regions: Category?
    var stockTypes: Category?
    
    init(json: JSON){
        netAssetAllocation = Category.init(json["netAssetAllocation"])
        sectors = Category.init(json["sectors"])
        positions = Category.init(json["positions"])
        regions = Category.init(json["regions"])
        stockTypes = Category.init(json["stockTypes"])
    }
}

class Category {
    var categoryTitle: String?
    var entryTitle: String?
    var totalAmount: EntityValue?
    var portfolioBreakdowns: [BreakdownItem]?
    
    init(_ json: JSON){
        categoryTitle = json["categoryTitle"].string
        entryTitle = json["entryTitle"].string
        totalAmount = EntityValue.init(json["totalAmount"])
        
        let jsonArray = json["portfolioBreakdowns"].array
        
        portfolioBreakdowns = [BreakdownItem]()
        
        for breakdown in jsonArray!{
            let breakdown = BreakdownItem.init(json: breakdown)
            portfolioBreakdowns?.append(breakdown)
        }
    }
}

class BreakdownItem {
    var name: String?
    var shortName: String?
    var percentage: EntityValue?
    var amount: EntityValue?
    
    init(json: JSON){
        name = json["name"].string
        shortName = json["shortName"].string
        percentage = EntityValue.init(json["percentage"])
        amount = EntityValue.init(json["amount"])
    }
}

class EntityValue {
    var value: Double?
    var formattedValue: String?
    
    init(_ json: JSON){
        value = json["value"].double
        formattedValue = json["formattedValue"].string
    }
}
