import UIKit

class ProductCell: UITableViewCell {
    
    static let reuseID = "ProductCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup() {
        backgroundColor = .red
    }

}
