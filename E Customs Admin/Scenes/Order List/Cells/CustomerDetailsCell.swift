import UIKit

class CustomerDetailsCell: UITableViewCell {

    // MARK: Properties
    static let reuseID = "CustomerDetailsCell"
    
    fileprivate let titleLabel = ECMediumLabel(text: Strings.customerDetails, textAlignment: .left, fontSize: 17)
    
    fileprivate let fullnameLabel = ECMediumLabel(text: Strings.fullname, textAlignment: .left, fontSize: 17)
    fileprivate let fullnameValueLabel = ECRegularLabel(textAlignment: .left, fontSize: 15, numberOfLines: 0)
    
    fileprivate let emailLabel = ECMediumLabel(text: Strings.email, textAlignment: .left, fontSize: 17)
    fileprivate let emailValueLabel = ECRegularLabel(textAlignment: .left, fontSize: 15, numberOfLines: 0)
    
    fileprivate let genderLabel = ECMediumLabel(text: Strings.gender, textAlignment: .left, fontSize: 17)
    fileprivate let genderValueLabel = ECRegularLabel(textAlignment: .left, fontSize: 15)
    
    fileprivate let addressLabel = ECMediumLabel(text: Strings.shippingAddress, textAlignment: .left, fontSize: 17)
    fileprivate let addressValueLabel = ECRegularLabel(textAlignment: .left, fontSize: 15, numberOfLines: 0)

    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Public Methods
extension CustomerDetailsCell {
    
    func set(user: User, address: String) {
        fullnameValueLabel.text = "\(user.firstname ?? "") \(user.lastname ?? "")"
        emailValueLabel.text = "\(user.email ?? "")"
        addressValueLabel.text = address
        
        if user.isMale ?? false {
            genderValueLabel.text = Strings.male
        } else {
            genderValueLabel.text = Strings.female
        }
    }
}


// MARK: - Fileprivate Methods
fileprivate extension CustomerDetailsCell {
    
    func setupUI() {
        selectionStyle = .none
        let padding: CGFloat = 24
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, fullnameLabel, fullnameValueLabel, emailLabel, emailValueLabel, genderLabel, genderValueLabel, addressLabel, addressValueLabel])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .leading
        
        contentView.addSubviews(stackView)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
    }
}
