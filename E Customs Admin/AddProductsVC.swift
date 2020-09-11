import UIKit

class AddProductsVC: UIViewController {
    
    fileprivate let photoButton = ECButton(backgroundColor: .white, title: "Select Photo", fontSize: 21)
    fileprivate let nameTextField = ECTextField(padding: 16, placeholderText: "Enter product name")
    fileprivate let priceTextField = ECTextField(padding: 16, placeholderText: "Enter price")
    fileprivate let sizesTextField = ECTextField(padding: 16, placeholderText: "Enter sizes")
    fileprivate let saveButton = ECButton(backgroundColor: UIColor.appColor(.lightGray), title: "Save", titleColor: .gray, fontSize: 21)
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, priceTextField, sizesTextField, saveButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 18
        return stackView
    }()
    
    fileprivate lazy var overrallStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoButton, verticalStackView])
        stackView.axis = .vertical
        stackView.spacing = 18
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Add Sneaker"
        
        nameTextField.autocorrectionType = .no
        priceTextField.keyboardType = .decimalPad
        priceTextField.autocorrectionType = .no
        sizesTextField.autocorrectionType = .no
        saveButton.isEnabled = false
        
        photoButton.setRoundedBorder(borderColor: .black, borderWidth: 1, radius: 2)
        nameTextField.setRoundedBorder(borderColor: .black, borderWidth: 1, radius: 2)
        priceTextField.setRoundedBorder(borderColor: .black, borderWidth: 1, radius: 2)
        sizesTextField.setRoundedBorder(borderColor: .black, borderWidth: 1, radius: 2)
        saveButton.setRoundedBorder(borderColor: .black, borderWidth: 1, radius: 2)
        
        view.addSubview(overrallStackView)
        photoButton.heightAnchor.constraint(equalToConstant: 275).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        overrallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
    }
}
