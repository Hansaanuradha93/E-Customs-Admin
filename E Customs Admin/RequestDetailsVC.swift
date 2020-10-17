import UIKit

class RequestDetailsVC: UIViewController {
    
    // MARK: Properties
    fileprivate let viewModel = RequestDetailsVM()
    var request: Request!
    
    fileprivate let scrollView = UIScrollView()
    fileprivate let contentView = UIView()
    
    fileprivate let thumbnailImageView = ECImageView(contentMode: .scaleAspectFill)
    fileprivate let sneakerNameLabel = ECMediumLabel(textAlignment: .left, fontSize: 17)
    fileprivate let ideaDescriptionLabel =  ECRegularLabel(textAlignment: .left, textColor: .lightGray, fontSize: 15, numberOfLines: 0)
    fileprivate let statusLabel = ECMediumLabel(textAlignment: .left, fontSize: 17)
    fileprivate let priceTextField = ECTextField(padding: 16, placeholderText: Strings.price)
    fileprivate let approveButton = ECButton(backgroundColor: UIColor.appColor(.lightGray), title: Strings.approve, titleColor: .gray, radius: GlobalConstants.cornerRadius, fontSize: 18)
    
    
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
        setupScrollView()
        setupUI()
        setData()
        setupViewModelObserver()
    }
}


// MARK: - Methods
extension RequestDetailsVC {
    
    @objc fileprivate func handleApprove() {
        var title = ""
        var message = ""
        
        if request.isApproved ?? false {
            title = "Confirm Change"
            message = "Do you want to change the price"
        } else {
            title = Strings.confirmApproval
            message = Strings.approvalConfirmation
        }
        
        presentAlertAction(title: title, message: message, rightButtonTitle: Strings.yes, leftButtonTitle: Strings.no, rightButtonAction:  { (_) in
            self.approveRequest()
        })
    }
    
    
    @objc fileprivate func handleTextChange(textField: UITextField) {
        viewModel.price = priceTextField.text
    }
    
    
    fileprivate func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.approveButton.backgroundColor = .black
                self.approveButton.setTitleColor(.white, for: .normal)
            } else {
                self.approveButton.backgroundColor = UIColor.appColor(.lightGray)
                self.approveButton.setTitleColor(.gray, for: .disabled)
            }
            self.approveButton.isEnabled = isFormValid
        }
        
        viewModel.bindableIsApproving.bind { [weak self] isSaving in
            guard let self = self, let isSaving = isSaving else { return }
            if isSaving {
                self.showPreloader()
            } else {
                self.hidePreloader()
            }
        }
    }
    
    
    fileprivate func approveRequest() {
        viewModel.approve(request: request) { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.presentAlert(title: Strings.successfull, message: message, buttonTitle: Strings.ok)
                self.updateUI()
            } else {
                self.presentAlert(title: Strings.failed, message: message, buttonTitle: Strings.ok)
            }
        }
    }
    
    
    fileprivate func updateUI() {
        statusLabel.text = Strings.requestApproved
        approveButton.setTitle(Strings.changePrice, for: .normal)
        priceTextField.text = ""
        viewModel.price = ""
        view.endEditing(true)
    }
    
    
    fileprivate func setData() {
        thumbnailImageView.downloadImage(from: request.thumbnailUrl ?? "")
        sneakerNameLabel.text = (request.sneakerName ?? "").uppercased()
        ideaDescriptionLabel.text = request.ideaDescription ?? ""
        
        if request.isApproved ?? false {
            statusLabel.text = Strings.requestApproved
            approveButton.setTitle(Strings.changePrice, for: .normal)
        } else {
            statusLabel.text = Strings.requestPending
            approveButton.setTitle(Strings.approve, for: .normal)
        }
    }
    
    
    fileprivate func setupUI() {
        priceTextField.keyboardType = .decimalPad
        priceTextField.autocorrectionType = .no
        priceTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        priceTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        approveButton.addTarget(self, action: #selector(handleApprove), for: .touchUpInside)
        approveButton.isEnabled = false
        
        contentView.addSubviews(thumbnailImageView, sneakerNameLabel, ideaDescriptionLabel, statusLabel, priceTextField,approveButton)

        let paddingTop: CGFloat = 36
        let paddingCorners: CGFloat = 24
        
        thumbnailImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingCorners, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 375))
        sneakerNameLabel.anchor(top: thumbnailImageView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners))
        ideaDescriptionLabel.anchor(top: sneakerNameLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners))
        statusLabel.anchor(top: ideaDescriptionLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners))
        priceTextField.anchor(top: statusLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners))
        approveButton.anchor(top: priceTextField.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners), size: .init(width: 0, height: GlobalConstants.height))
    }
    
    
    fileprivate func setupScrollView(){
        view.backgroundColor = .white
        title = Strings.requestDetail
        tabBarItem.title = Strings.empty
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.fillSuperview()
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 950)
        ])
    }
}
