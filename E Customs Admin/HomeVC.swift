import UIKit
import Firebase

class HomeVC: UITableViewController {

    // MARK: Properties
    let viewModel = HomeVM()
    fileprivate var listener: ListenerRegistration?
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProducts()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent { listener?.remove() }
    }
}


// MARK: - UITableView
extension HomeVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = .red
        return cell
    }
}


// MARK: - Methods
extension HomeVC {
    
    fileprivate func fetchProducts() {
        listener = viewModel.fetchProducts { (status) in
            if status {
                print(self.viewModel.products)
            }
        }
    }
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
}
