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
    static let emptyCart = UIImage(named: "emptyCart")!
    static let emptyDocument = UIImage(named: "emptyDocument")!
    static let emptyEnvelope = UIImage(named: "emptyEnvelope")!
    static let emptyShoe = UIImage(named: "emptyShoe")!
    
    // Order
    static let close = UIImage(systemName: "xmark")!
    
    // Profile
    static let user = UIImage(named: "user")!
}


// MARK: - Strings
struct Strings {
    
    // Credentials
    static let adminEmail = "ecustomsadmin@gmail.com"
    static let adminPassword = "ecustomsadmin123"
    
    // Titles
    static let home = "HOME"
    static let addSneaker = "ADD SNEAKER"
    static let detail = "DETAIL"
    static let bag = "BAG"
    static let requestList = "REQUEST LIST"
    static let requestDetail = "REQUEST DETAIL"
    static let profile = "PROFILE"
    static let orders = "ORDERS"
    static let orderDetail = "ORDER DETAIL"
    
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
    static let somethingWentWrong = "Something Went Wrong, Please Try Again"
    static let yes = "Yes"
    static let no = "No"
    static let authenticationSuccessfull = "Authentication successfull"
    static let loggedInSuccessfully = "Logged in successfully"
    static let confirmApproval = "Confirm Approval"
    static let approvalConfirmation = "Do you want to approve the request"
    static let productSaved = "Product save successfully"
    static let productAlreadyInBag = "Product is already in the Bag"
    static let productAddedToBag = "Poduct added to Bag successfully!"
    static let requestUpdated = "Request updated successfully"
    static let orderStatusUpdatedTo = "Order status updated to"
    static let confirmChange = "Confirm Change"
    static let doYouWantToChangeThePrice = "Do you want to change the price"
    
    // Labels
    static let size = "Size"
    static let gender = "Gender"
    static let lodingIndicatorDots = "..."
    static let role = "Role"
    static let admin = "Admin"
    static let customer = "Customer"
    static let qty = "Qty"
    static let select = "Select"
    static let noShoesYet = "No Shoes Yet"
    static let noItemsYet = "No Items Yet"
    static let noRequestsYet = "No Requests Yet"
    static let noOrdersYet = "No Orders Yet"
    static let notAvailable = "Not available"
    static let subtotal = "Subtotal"
    static let shipping = "Shipping"
    static let paymentMethod = "Payment Method"
    static let processingFees = "Processing Fees"
    static let total = "Total"
    static let requestIsApproved = "REQUEST IS APPROVED"
    static let requestIsPending = "REQUEST IS STILL PENDING"
    static let requestApproved = "Request Approved"
    static let requestPending = "Request Pending"
    static let designDescription = "DESIGN DESCRIPTION"
    static let customerDetails = "CUSTOMER DETAILS"
    static let fullname = "Full Name"
    static let shippingAddress = "Shipping Address"
    
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
    static let signout = "SIGN OUT"
    static let updateOrder = "UPDATE ORDER"
    static let done = "DONE"
    static let changePrice = "CHANGE PRICE"
}


// MARK: - Fonts
struct Fonts {
    static let avenirNext = "Avenir Next"
}


// MARK: - GlobalConstants
struct GlobalConstants {
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = 3
    static let borderWidth: CGFloat = 0.5
    static let borderColor: UIColor = .gray
}

