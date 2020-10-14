import UIKit
import Firebase

class OrderListVM {
    
    // MARK: Properties
    var orders = [Order]()
    fileprivate var ordersDictionary = [String : Order]()
}


// MARK: - Methods
extension OrderListVM {
    
    func fetchOrders(completion: @escaping (Bool) -> ()) -> ListenerRegistration? {
        let reference = Firestore.firestore().collection("orders")
        
        orders.removeAll()
                
        let listener = reference.addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            
            guard let documentChanges = querySnapshot?.documentChanges else {
                completion(false)
                return
            }
            
            for change in documentChanges {
                if change.type == .added {
                    let order = Order(dictionary: change.document.data())
                    self.ordersDictionary[order.orderId ?? ""] = order
                }
            }
            self.sortOrdersByTimestamp(completion: completion)
        }
        return listener
    }
    
    
    fileprivate func sortOrdersByTimestamp(completion: @escaping (Bool) -> ()) {
        let values = Array(ordersDictionary.values)
        orders = values.sorted(by: { (order1, order2) -> Bool in
            guard let timestamp1 = order1.timestamp, let timestamp2 = order2.timestamp else { return false }
            return timestamp1.compare(timestamp2) == .orderedDescending
        })
        completion(true)
    }
}
