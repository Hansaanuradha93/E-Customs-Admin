import Foundation

public enum ButtonType {
    case checkout
    case checkOrders
    case orderDetails
}


public enum OrderStatusType: String {
    case created = "Created"
    case processing = "Processing"
    case shipped = "Shipped"
    case completed = "Completed"
}


public enum EmptyStateType {
    case home
    case requestBox
    case shoppinBag
    case order
}
