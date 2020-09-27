import UIKit

class ECTextField: UITextField {
    
    // MARK: Properties
    fileprivate var padding: CGFloat = 0
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(background: UIColor = .white, padding: CGFloat, placeholderText: String = "", fontSize: CGFloat = 16, radius: CGFloat = 0) {
        self.init()
        self.padding = padding
        self.placeholder = placeholderText
        self.layer.cornerRadius = radius
        
        let traits = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.regular]
        var descriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: Fonts.avenirNext])
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: traits])
        self.font = UIFont(descriptor: descriptor, size: fontSize)
    }
    
    
    required init?(coder: NSCoder) { fatalError() }

    
    // MARK: Overridden Methods
    override func editingRect(forBounds bounds: CGRect) -> CGRect { return bounds.insetBy(dx: padding, dy: 0) }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect { return bounds.insetBy(dx: padding, dy: 0) }
    
    
    override var intrinsicContentSize: CGSize { return .init(width: 0, height: 50) }
}
