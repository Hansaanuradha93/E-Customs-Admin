import UIKit

class AddProductsVC: UIViewController {
    
    // MARK: Properties
    fileprivate let viewModel = AddProductsVM()
    
    fileprivate let photoButton = ECButton(backgroundColor: UIColor.appColor(.lightGray), title: Strings.selectPhoto, titleColor: .gray, fontSize: 21)
    fileprivate let nameTextField = ECTextField(padding: 16, placeholderText: Strings.productName)
    fileprivate let descriptionTextField = ECTextField(padding: 16, placeholderText: Strings.description)
    fileprivate let priceTextField = ECTextField(padding: 16, placeholderText: Strings.price)
    fileprivate let sizesTextField = ECTextField(padding: 16, placeholderText: Strings.sizes)
    fileprivate let saveButton = ECButton(backgroundColor: UIColor.appColor(.lightGray), title: Strings.save, titleColor: .gray, fontSize: 18)
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, descriptionTextField, priceTextField, sizesTextField, saveButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        return stackView
    }()
    
    fileprivate lazy var overrallStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoButton, verticalStackView])
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()

    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargets()
        setupNotifications()
        setupViewModelObserver()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - Objc Methods
fileprivate extension AddProductsVC {
    
    @objc func handleSave() {
        handleTapDismiss()
        
        viewModel.saveImageToFirebase { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.presentAlert(title: Strings.successfull, message: message, buttonTitle: Strings.ok)
                self.clearData()
            } else {
                self.presentAlert(title: Strings.failed, message: message, buttonTitle: Strings.ok)
            }
        }
    }
    
    
    @objc func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    
    @objc func handleTextChange(textField: UITextField) {
        viewModel.name = nameTextField.text
        viewModel.description = descriptionTextField.text
        viewModel.price = priceTextField.text
        viewModel.sizes = sizesTextField.text
    }
    
    
    @objc func handleTapDismiss() {
        view.endEditing(true)
    }
    
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.overrallStackView.transform = .identity
        })
    }
    
    
    @objc func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let bottomSpace = view.frame.height - overrallStackView.frame.origin.y - overrallStackView.frame.height
        let difference = keyboardFrame.height - bottomSpace
        self.overrallStackView.transform = CGAffineTransform(translationX: 0, y: -(difference + 10))
    }
}


// MARK: - Fileprivate Methods
fileprivate extension AddProductsVC {
    
    func clearData() {
        photoButton.setImage(nil, for: .normal)
        nameTextField.text = ""
        descriptionTextField.text = ""
        priceTextField.text = ""
        sizesTextField.text = ""
        
        viewModel.bindableImage.value = nil
        viewModel.name = ""
        viewModel.description = ""
        viewModel.price = ""
        viewModel.sizes = ""
    }
    
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.saveButton.backgroundColor = .black
                self.saveButton.setTitleColor(.white, for: .normal)
            } else {
                self.saveButton.backgroundColor = UIColor.appColor(.lightGray)
                self.saveButton.setTitleColor(.gray, for: .disabled)
            }
            self.saveButton.isEnabled = isFormValid
        }
        
        viewModel.bindableImage.bind { [weak self] image in
            guard let self = self else { return }
            let buttonImage = image?.withRenderingMode(.alwaysOriginal)
            self.photoButton.setImage(buttonImage, for: .normal)
        }
        
        viewModel.bindableIsSaving.bind { [weak self] isSaving in
            guard let self = self, let isSaving = isSaving else { return }
            if isSaving {
                self.showPreloader()
            } else {
                self.hidePreloader()
            }
        }
    }
    
    
    func addTargets() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        photoButton.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        priceTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        sizesTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = Strings.addSneaker
        tabBarItem.title = Strings.empty
        
        nameTextField.autocorrectionType = .no
        priceTextField.keyboardType = .decimalPad
        priceTextField.autocorrectionType = .no
        sizesTextField.autocorrectionType = .no
        saveButton.isEnabled = false
        
        photoButton.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: 0, radius: GlobalConstants.cornerRadius)
        nameTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        descriptionTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        priceTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        sizesTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        saveButton.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: 0, radius: GlobalConstants.cornerRadius)
        
        let paddingCorners: CGFloat = 24
        view.addSubview(overrallStackView)
        photoButton.heightAnchor.constraint(equalToConstant: 215).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: GlobalConstants.height).isActive = true
        overrallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: paddingCorners, bottom: 0, right: paddingCorners))
    }
}


// MARK: - UIImagePickerControllerDelegate && UINavigationControllerDelegate
extension AddProductsVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: ImagePicker.EditedImage.key)] as? UIImage {
            viewModel.bindableImage.value = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: ImagePicker.OriginalImage.key)] as? UIImage {
            viewModel.bindableImage.value = originalImage
        }
        viewModel.checkFormValidity()
        dismiss(animated: true, completion: nil)
    }
}
