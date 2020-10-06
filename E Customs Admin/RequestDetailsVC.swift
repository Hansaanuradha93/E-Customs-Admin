import UIKit

class RequestDetailsVC: UIViewController {
    
    // MARK: Properties
    fileprivate let viewModel = RequestDetailsVM()
    var request: Request!
    
    
    // MARK: Initializers
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    convenience init(request: Request) {
        self.init()
        self.request = request
    }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: - Methods
extension RequestDetailsVC {
    
    fileprivate func setup(){
        view.backgroundColor = .white
        title = Strings.detail
        tabBarItem.title = Strings.empty
    }
}
