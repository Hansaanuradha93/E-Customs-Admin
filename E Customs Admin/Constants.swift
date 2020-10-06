import UIKit

// MARK: - Asserts
struct Asserts {
    
    // Images
    static let placeHolder = UIImage(named: "placeholder")!
    
    // System Icons
    static let house = UIImage(systemName: "house")
    static let houseFill = UIImage(systemName: "house.fill")
    static let plus = UIImage(systemName: "plus")
    static let document = UIImage(systemName: "doc.text")
    static let documentFill = UIImage(systemName: "doc.text.fill")
    static let envelope = UIImage(systemName: "envelope")
    static let envelopeFill = UIImage(systemName: "envelope.fill")
}


// MARK: - Fonts
struct Fonts {
    static let avenirNext = "Avenir Next"
}


// MARK: - Strings
struct Strings {
    
    // Titles
    static let home = "HOME"
    static let addSneaker = "ADD SNEAKER"
    static let detail = "DETAIL"
    static let bag = "BAG"
    static let requestBox = "REQUEST BOX"
    
    
    // Placeholders
    static let empty = ""
    static let email = "Email"
    static let password = "Password"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    
    static let productName = "Product Name"
    static let description = "Description"
    static let price = "Price"
    static let sizes = "Sizes"
    
    
    // Alerts
    static let failed = "Failed"
    static let successfull = "Successful"
    
    static let productSavingFailed = "Poduct saving failed!"
    static let productSavedSuccessfully = "Poduct saved successfully!"
    static let productAddingToBagFailed = "Product Adding to Bag Failed"
    static let productAddedToBagSuccessfully = "Poduct added to Bag successfully!"
    
    // Buttons
    static let ok = "OK"
    static let done = "DONE"
    static let login = "LOG IN"
    static let gotoSignup = "Go to sign up"
    static let signup = "SIGN UP"
    static let gotoLogin = "Go to login"
    static let male = "Male"
    static let female = "Female"
    static let addToBag = "ADD TO BAG"
    static let checkout = "CHECKOUT"
    static let selectPhoto = "Select Photo"
    static let save = "SAVE"
    static let approve = "APPROVE"
    
    // Labels
    static let size = "Size"
    static let noItemsYet = "NO ITEMS YET"
    static let notAvailable = "Not available"
    static let qty = "Qty"
    static let free = "Free"
    static let subtotal = "Subtotal"
    static let shipping = "Shipping"
    static let tax = "Tax"
    static let total = "Total"
}


struct GlobalConstants {
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = 3
    static let borderWidth: CGFloat = 0.5
    static let borderColor: UIColor = .gray
}

