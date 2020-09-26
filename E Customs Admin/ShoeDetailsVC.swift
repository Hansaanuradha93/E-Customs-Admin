import UIKit

class ProductsDetailsVC: UIViewController {

    // MARK: Properties
    var viewModel: ShoeDetialsVM!
    
    
    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    convenience init(viewModel: ShoeDetialsVM) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
//        print(viewModel.product)
    }
}
