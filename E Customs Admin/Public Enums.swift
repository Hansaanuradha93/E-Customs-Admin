import Foundation

public enum ButtonType {
    case checkout
    case checkOrders
    case orderDetails
}


public enum ItemType {
    case bagItem
    case orderItem
}


public enum OrderStatusType: String {
    case created = "Created"
    case processing = "Processing"
    case shipped = "Shipped"
    case completed = "Completed"
    case canceled = "Canceled"
}
