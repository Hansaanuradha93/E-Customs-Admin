import UIKit

class ButtonCell: UITableViewCell {

    // MARK: Properties
    static let reuseID = "CheckoutButtonCell"
    
    private let button = ECButton(backgroundColor: .black, titleColor: .white, radius: GlobalConstants.cornerRadius, fontSize: 16)
    var buttonAction: (() -> Void)? = nil

    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Public Methods
extension ButtonCell {
    
    func set(buttonType: ButtonType) {
        var title = ""
        if buttonType == .checkout {
            title = Strings.checkout
        } else if buttonType == .checkOrders {
            title = Strings.checkOrders
        } else if buttonType == .orderDetails {
            title = Strings.updateOrder
        }
        button.setTitle(title, for: .normal)
    }
}


// MARK: - Private Methods
private extension ButtonCell {
    
    @objc func handleButtonAction() {
        buttonAction?()
    }
    
    
    func setupUI() {
        selectionStyle = .none
        button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        
        let padding: CGFloat = 24
        contentView.addSubview(button)
        
        button.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding))
        button.centerVertically(in: self, size: .init(width: 0, height: GlobalConstants.height))
    }
}
