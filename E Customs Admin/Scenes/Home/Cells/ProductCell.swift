import UIKit

class ProductCell: UITableViewCell {
    
    // MARK: Properties
    static let reuseID = "ProductCell"
    
    private let thumbnailImageView = ECImageView(image: Asserts.placeHolder)
    private let titleLabel = ECMediumLabel(textAlignment: .left, fontSize: 17)
    private let priceLabel = ECRegularLabel(textAlignment: .left, fontSize: 15)

    
    // MARK: Initilizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Public Methods
extension ProductCell {
    
    func set(product: Product) {
        titleLabel.text = product.name ?? ""
        priceLabel.text = "$\(product.price ?? "")"
        thumbnailImageView.downloadImage(from: product.thumbnailUrl ?? "")
    }
}


// MARK: - Fileprivate Methods
fileprivate extension ProductCell {
    
    func setupUI() {
        selectionStyle = .none
        contentView.addSubviews(thumbnailImageView, titleLabel, priceLabel)
        
        thumbnailImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: .init(width: 0, height: 375))
        titleLabel.anchor(top: thumbnailImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        priceLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: 0))
    }
}
