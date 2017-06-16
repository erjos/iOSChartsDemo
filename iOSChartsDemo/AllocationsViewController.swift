import Foundation
import Charts

class AllocationsViewController: UIViewController {
    
    @IBOutlet weak var allocationsChartView: PieChartView!
    
    override func viewDidLoad() {
        setAllocationsChart()
    }
    
    func setAllocationsChart(){
        
        let arrayOfDataSet = [IChartDataSet]()
        
        let allocationsEntries = [PieChartDataEntry]()
        
        // haven't found this yet in POC bet extrapolating
        let allocationsDataSet = PieChartDataSet(values: allocationsEntries, label: "Herroo")
        
        //TODO: use below to pass in the array of colors that we will use for the wheel
        //allocationsDataSet.setColors(<#T##colors: [NSUIColor]##[NSUIColor]#>, alpha: <#T##CGFloat#>)
    
        //TODO: can also initialize the data with an array of dataSets *** I wonder what this does - check it out later
        let allocationsData = PieChartData(dataSet: allocationsDataSet)
        
        allocationsChartView.data = allocationsData
    }
}
