import Foundation
import Charts

class AllocationsViewController: UIViewController {
    
    @IBOutlet weak var allocationsChartView: PieChartView!
    
    override func viewDidLoad() {
        setAllocationsChart()
    }
    
    
    
    
    func setAllocationsChart(){
        
        let arrayOfDataSet = [IChartDataSet]()
        
        //These entries are constructed using the RowItems from a list of PorfolioBreakdown objects ->uses a stream and filter to map to the list
        let allocationsEntries = [PieChartDataEntry]()
        
        // haven't found this yet in POC yet
        let allocationsDataSet = PieChartDataSet(values: allocationsEntries, label: "Herroo")
        
        //TODO: use below to pass in the array of colors that we will use for the wheel
        //allocationsDataSet.setColors(<#T##colors: [NSUIColor]##[NSUIColor]#>, alpha: <#T##CGFloat#>)
    
        //TODO: can also initialize the data with an array of dataSets *** I wonder what this does - check it out later
        let allocationsData = PieChartData(dataSet: allocationsDataSet)
        
        allocationsChartView.data = allocationsData
    }
}

class PortfolioBreakdown {
    var positions: [BreakdownPosition]?
    var assetAllocation: AssetAllocation?
    var sectors: Sectors?
    var regions: [Region]?
    var types: Types?
    
    var hasPositions: Bool {
        return positions != nil && (positions?.count)! > 0
    }
    
    var hasAssetAllocation: Bool {
        return assetAllocation != nil
    }
    
    var hasSectors: Bool {
        return sectors != nil
    }
    
    var hasRegions: Bool{
        return regions != nil && (regions?.count)! > 0
    }
    
    var hasTypes: Bool{
        return types != nil
    }
}

class BreakdownPosition {
    var name: String?
    var asset: Float?
    var value: Float?
    var type: String?
    var category: String?
    var country: String?
    var currencyType: String?
    var symbol: String?
}

class AssetAllocation {
    var cash: Float?
    var usStocks: Float?
    var nonUsStocks: Float?
    var bonds: Float?
    var other: Float?
    var nonClassified: Float?
    var total: Float?
}

class Sectors {
    var energy: Float?
    var materials: Float?
    var industrials: Float?
    var consumerDiscretionary: Float?
    var consumerStaples: Float?
    var healthCare: Float?
    var financials: Float?
    var informationTechnology: Float?
    var telecommunicationServices: Float?
    var utilities: Float?
    var notClassified: Float?
}

class Region {
    var name: String?
    var stock: Float?
    var totalStock: Float?
    var subRegion: [Region]?
}

class Types {
    var aggressiveGrowth: Float?
    var classicGrowth: Float?
    var cyclical: Float?
    var distressed: Float?
    var hardAsset: Float?
    var highYield: Float?
    var notClassified: Float?
    var slowGrowth: Float?
    var speculativeGrowth: Float?
}
