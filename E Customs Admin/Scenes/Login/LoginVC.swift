import UIKit

class LoginVC: UIViewController {
    
    // MARK: Properties
    private let viewModel = LoginVM()
    
    private let emailTextField = ECTextField(padding: 16, placeholderText: Strings.email)
    private let passwordTextField = ECTextField(padding: 16, placeholderText: Strings.password)
    private let loginButton = ECButton(backgroundColor: UIColor.appColor(.lightGray), title: Strings.login, titleColor: .gray, fontSize: 18)
    private let gotoSignupButton = ECButton(backgroundColor: .white, title: Strings.gotoSignup, titleColor: .black, fontSize: 15)
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
        addDebugLoginCredentials()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}


// MARK: - Objc Methods
private extension LoginVC {
    
    @objc func handleLogin() {
        handleTapDismiss()
        viewModel.performLogin { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.navigateToHome()
            } else {
                self.presentAlert(title: Strings.failed, message: message, buttonTitle: Strings.ok)
            }
        }
    }
    
    
    @objc func handleTextChange(textField: UITextField) {
        viewModel.email = emailTextField.text
        viewModel.password = passwordTextField.text
    }
    
    
    @objc func handleTapDismiss() {
        view.endEditing(true)
    }
    
    
    @objc func handleKeyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.verticalStackView.transform = .identity
        })
    }
    
    
    @objc func handleKeyboardShow(notification: Notification) {
        self.verticalStackView.transform = CGAffineTransform(translationX: 0, y: -10)
    }
    
    
    @objc func handleGoToLogin() {
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - Private Methods
private extension LoginVC {
    
    func navigateToHome() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = ECTabBar()
    }
    
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func setupViewModelObserver() {
        viewModel.bindalbeIsFormValid.bind { [weak self] isFormValid in
            guard let self = self, let isFormValid = isFormValid else { return }
            if isFormValid {
                self.enableLoginButton()
            } else {
                self.disableLoginButton()
            }
        }
        
        viewModel.bindableIsLogin.bind { [weak self] isLogin in
            guard let self = self, let isLogin = isLogin else { return }
            if isLogin {
                self.showPreloader()
            } else {
                self.hidePreloader()
            }
        }
    }
    
    func disableLoginButton() {
        loginButton.backgroundColor = UIColor.appColor(.lightGray)
        loginButton.setTitleColor(.gray, for: .disabled)
        loginButton.isEnabled = false
    }
    
    
    func enableLoginButton() {
        loginButton.backgroundColor = .black
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.isEnabled = true
    }
    
    
    func addTargets() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
        emailTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        gotoSignupButton.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
    }
    
    func addDebugLoginCredentials() {
        #if DEBUG
        emailTextField.text = Strings.adminEmail
        passwordTextField.text = Strings.adminPassword
        viewModel.email = Strings.adminEmail
        viewModel.password = Strings.adminPassword
        enableLoginButton()
        #endif
    }
    
    
    func setupUI() {
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        title = Strings.login
        tabBarItem.title = Strings.empty
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocorrectionType = .no
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        loginButton.isEnabled = false
        
        emailTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        passwordTextField.setRoundedBorder(borderColor: GlobalConstants.borderColor, borderWidth: GlobalConstants.borderWidth, radius: GlobalConstants.cornerRadius)
        loginButton.setRoundedBorder(borderColor: .black, borderWidth: 0, radius: 2)
        
        let paddingTop: CGFloat = 30
        let paddingCorners: CGFloat = 24
        view.addSubviews(verticalStackView, gotoSignupButton)
        loginButton.heightAnchor.constraint(equalToConstant: GlobalConstants.height).isActive = true
        verticalStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: paddingTop, left: paddingCorners, bottom: 0, right: paddingCorners))

        gotoSignupButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
}
