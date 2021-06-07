import UIKit

class RequestCell: UITableViewCell {
    
    // MARK: Properties
    static let reuseID = "RequestCell"
    
    private let thumbnailImageView = ECImageView(contentMode: .scaleAspectFill)
    private let sneakerNameLabel = ECRegularLabel(textAlignment: .left, fontSize: 15, numberOfLines: 2)
    private let ideaDescriptionLabel = ECRegularLabel(textAlignment: .left, textColor: .gray, fontSize: 15)
    private let statusLabel = ECRegularLabel(textAlignment: .left, textColor: .gray, fontSize: 15)
    private let priceLabel = ECRegularLabel(textAlignment: .left, textColor: .gray, fontSize: 15)
    private let separatorLine = UIView()

    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Public Methods
extension RequestCell {
    
    func set(request: Request, isLastRequest: Bool) {
        sneakerNameLabel.text = request.sneakerName ?? ""
        ideaDescriptionLabel.text = request.ideaDescription ?? ""
        thumbnailImageView.downloadImage(from: request.thumbnailUrl ?? "")
        statusLabel.text = request.requestStatusString
        priceLabel.text = request.price != nil ? "$\(request.price!)" : ""
        separatorLine.alpha = isLastRequest ? 0 : 1
    }
}


// MARK: - Fileprivate Methods
private extension RequestCell {
    
    func setupUI() {
        selectionStyle = .none
        
        let paddingTop: CGFloat = 24
        let dimensions: CGFloat = 102
        
        let stackView = UIStackView(arrangedSubviews: [sneakerNameLabel, ideaDescriptionLabel, statusLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        
        separatorLine.backgroundColor = .lightGray
        
        contentView.addSubviews(thumbnailImageView, stackView, separatorLine)

        thumbnailImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: paddingTop, left: paddingTop, bottom: 0, right: 0), size: .init(width: dimensions, height: dimensions))
        stackView.anchor(top: thumbnailImageView.topAnchor, leading: thumbnailImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: paddingTop / 2, bottom: paddingTop, right: paddingTop))
        separatorLine.anchor(top: thumbnailImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: paddingTop, left: paddingTop, bottom: 0, right: paddingTop), size: .init(width: 0, height: 0.2))
    }
}
