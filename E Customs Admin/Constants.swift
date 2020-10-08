import UIKit

// MARK: - Asserts
struct Asserts {

    // System Icons
    static let house = UIImage(systemName: "house")
    static let houseFill = UIImage(systemName: "house.fill")
    static let plus = UIImage(systemName: "plus")
    static let document = UIImage(systemName: "doc.text")
    static let documentFill = UIImage(systemName: "doc.text.fill")
    static let envelope = UIImage(systemName: "envelope")
    static let envelopeFill = UIImage(systemName: "envelope.fill")
    static let person = UIImage(systemName: "person")!
    static let personFill = UIImage(systemName: "person.fill")!
    
    // Common
    static let placeHolder = UIImage(named: "placeholder")!
    
    // Profile
    static let user = UIImage(named: "user")!
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
    static let requestList = "REQUEST LIST"
    static let requestDetail = "REQUEST DETAIL"
    static let profile = "PROFILE"
    static let orders = "ORDERS"
    
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
    
    // Buttons
    static let ok = "OK"
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
    static let checkOrders = "CHECK ORDERS"
    
    // Labels
    static let size = "Size"
}


struct GlobalConstants {
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = 3
    static let borderWidth: CGFloat = 0.5
    static let borderColor: UIColor = .gray
}

