import UIKit
import Firebase

class RequestListVC: UITableViewController {
    
    // MARK: Properties
    let viewModel = RequestListVM()
    private var listener: ListenerRegistration?

    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequests()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent { listener?.remove() }
    }
}


// MARK: - TableView
extension RequestListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requests.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestCell.reuseID, for: indexPath) as! RequestCell
        if viewModel.requests.count > 0 {
            let isLastRequest = (indexPath.row == viewModel.requests.count - 1)
            cell.set(request: viewModel.requests[indexPath.row], isLastRequest: isLastRequest)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = RequestDetailsVC(request: viewModel.requests[indexPath.row])
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - Fileprivate Methods
private extension RequestListVC {
    
    func fetchRequests() {
        listener = viewModel.fetchRequest { [weak self] status in
            guard let self = self else { return }
            if status {
                self.updateUI()
            }
        }
    }
    
    
    func updateUI() {
        if self.viewModel.requests.isEmpty {
            DispatchQueue.main.async { self.tableView.backgroundView = ECEmptyStateView(emptyStateType: .requestBox) }
        } else {
            DispatchQueue.main.async { self.tableView.backgroundView = nil }
        }
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.register(RequestCell.self, forCellReuseIdentifier: RequestCell.reuseID)
    }
    
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = Strings.requestList
        tabBarItem.title = Strings.empty
    }
}
