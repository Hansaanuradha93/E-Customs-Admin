import UIKit
import Firebase

class HomeVC: UIViewController {

    let viewModel = HomeVM()
    
    fileprivate var listener: ListenerRegistration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        listener = viewModel.fetchProducts { (status) in
            if status {
                print(self.viewModel.products)
                print("count", self.viewModel.products.count)
            }
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent { listener?.remove() }
    }
}
