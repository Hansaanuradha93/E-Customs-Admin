import UIKit
import Firebase

class RequestListVM {
    
    // MARK: Properties
    var requests = [Request]()
    fileprivate var requestsDictionary = [String : Request]()
}


// MARK: - Methods
extension RequestListVM {
    
    func fetchRequest(completion: @escaping (Bool) -> ()) -> ListenerRegistration? {
        let reference = Firestore.firestore().collection("requests")
        
        requests.removeAll()
        
        let listener = reference.addSnapshotListener { querySnapshot, error in
            if let error = error {
                print(error)
                completion(false)
                return
            }
            guard let documentChanges = querySnapshot?.documentChanges else {
                completion(false)
                return
            }
            for change in documentChanges {
                if change.type == .added {
                    let request = Request(dictionary: change.document.data())
                    self.requestsDictionary[request.id ?? ""] = request
                }
            }
            self.sortRequestsByTimestamp(completion: completion)
        }
        return listener
    }
    
    
    fileprivate func sortRequestsByTimestamp(completion: @escaping (Bool) -> ()) {
        let values = Array(requestsDictionary.values)
        requests = values.sorted(by: { (request1, request2) -> Bool in
            guard let timestamp1 = request1.timestamp, let timestamp2 = request2.timestamp else { return false }
            return timestamp1.compare(timestamp2) == .orderedDescending
        })
        completion(true)
    }
}
