import UIKit

class OrderDetailsVC: UITableViewController {
    
    // MARK: Properties
    var viewModel: OrderDetailsVM!
    let picker = UIPickerView()
    let toolBar = UIToolbar()
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        createToolBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCustomerDetails()
        fetchItems()
    }
}


// MARK: UITableView
extension OrderDetailsVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2: return viewModel.order.items.count > 0 ? viewModel.order.items.count : 1
        case 4: return (viewModel.order.description != nil) ? 1: 0
        case 5: return viewModel.user != nil ? 1 : 0
        case 6: return  (viewModel.order.status ?? "") != OrderStatusType.completed.rawValue ? 1 : 0
        default: return (viewModel.order.items.count > 0 && viewModel.user != nil) ? 1 : 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = viewModel.order
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: OrderHeaderCell.reuseID, for: indexPath) as! OrderHeaderCell
            cell.set(order: order)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NumberOfItemsCell.reuseID, for: indexPath) as! NumberOfItemsCell
            cell.set(count: order.itemCount ?? 0)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseID, for: indexPath) as! ItemCell
            if order.items.count > 0 {
                let item = order.items[indexPath.row]
                cell.set(item: item, itemType: .orderItem)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentInfoCell.reuseID, for: indexPath) as! PaymentInfoCell
            let subtotal = Int((order.subtotal ?? 0) * 100)
            let proccessingFeesPennies = Int((order.proccessingFees ?? 0) * 100)
            let totalPennies = Int((order.total ?? 0) * 100)

            cell.set(subtotalPennies: subtotal, processingFeesPennies: proccessingFeesPennies, totalPennies: totalPennies, paymentMethod: order.paymentMethod ?? "", shippingMethod: order.shippingMethod ?? "")
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.reuseID, for: indexPath) as! DescriptionCell
            cell.set(description: order.description)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomerDetailsCell.reuseID, for: indexPath) as! CustomerDetailsCell
            if let user = viewModel.user, let address = viewModel.order.address {
                cell.set(user: user, address: address)
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseID, for: indexPath) as! ButtonCell
            cell.set(buttonType: .orderDetails)
            
            cell.buttonAction = {
                self.showPickerWithAnimation()
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        case 1:
            return 70
        case 2:
            return 185
        case 3:
            return 200
        case 4:
            return viewModel.orderDesriptionCellHeight
        case 5:
            return 450
        case 6:
            return 100
        default:
            return 0
        }
    }
}

// MARK: - Objc Method
extension OrderDetailsVC {
    
    @objc fileprivate func handleDone() {
        updateOrderStatus()
        hidePickerWithAnimation()
    }
    
    
    @objc fileprivate func handleTap() {
        hidePickerWithAnimation()
    }
}


// MARK: - Fileprivate Methods
fileprivate extension OrderDetailsVC {
    
    func showPickerWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.picker.alpha = 1
            self.toolBar.alpha = 1
        }
    }
    
    
    func hidePickerWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.picker.alpha = 0
            self.toolBar.alpha = 0
        }
    }
    
    
    func createToolBar() {
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: Strings.done, style: .plain, target: self, action: #selector(handleDone))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.barTintColor = .white
        toolBar.tintColor = .black
        toolBar.alpha = 0
        view.addSubview(toolBar)
        
        toolBar.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: picker.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    
    func updateUI() {
        viewModel.order.status = viewModel.seletedOrderStatus
        let indexPath = IndexPath(row: 0, section: 0)
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    
    func updateOrderStatus() {
        viewModel.updateOrderStatus { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.presentAlert(title: Strings.successfull, message: message, buttonTitle: Strings.ok)
                self.updateUI()
            } else {
                self.presentAlert(title: Strings.failed, message: message, buttonTitle: Strings.ok)
            }
        }
    }
    
    
    func fetchCustomerDetails() {
        viewModel.fetchCustomerDetails { [weak self] status in
            guard let self = self else { return }
            if status {
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
    }
    
    func fetchItems() {
        viewModel.fetchItems { [weak self] status in
            guard let self = self else { return }
            if status {
                DispatchQueue.main.async { self.tableView.reloadData() }
            }
        }
    }
    
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = Strings.orderDetail
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        picker.alpha = 0
        picker.backgroundColor = .white
        view.addSubview(picker)
        picker.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        picker.dataSource = self
        picker.delegate = self
                
        tableView.separatorStyle = .none
        tableView.register(OrderHeaderCell.self, forCellReuseIdentifier: OrderHeaderCell.reuseID)
        tableView.register(NumberOfItemsCell.self, forCellReuseIdentifier: NumberOfItemsCell.reuseID)
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.reuseID)
        tableView.register(PaymentInfoCell.self, forCellReuseIdentifier: PaymentInfoCell.reuseID)
        tableView.register(CustomerDetailsCell.self, forCellReuseIdentifier: CustomerDetailsCell.reuseID)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.reuseID)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseID)
    }
}


// MARK: - UIPickerViewDataSource && UIPickerViewDelegate
extension OrderDetailsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.orderStatusArray.count
    }

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.orderStatusArray[row].rawValue
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.seletedOrderStatus = viewModel.orderStatusArray[row].rawValue
    }
}
