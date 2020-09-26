import UIKit

class ProductDetailsVC: UIViewController {

    // MARK: Properties
    var viewModel: ProductDetialsVM!
    
    
    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    convenience init(viewModel: ProductDetialsVM) {
        self.init()
        self.viewModel = viewModel
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        title = "DETAIL"
        tabBarItem.title = ""
    }
}
