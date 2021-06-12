import UIKit
import Firebase

final class RequestListVM {
    
    // MARK: Properties
    var requests = [Request]()
    private var requestsDictionary = [String : Request]()
}


// MARK: - Methods
extension RequestListVM {
    
    func fetchRequest(completion: @escaping (Bool) -> ()) -> ListenerRegistration? {
        let reference = Firestore.firestore().collection("requests")
        
        requests.removeAll()
        
        let listener = reference.addSnapshotListener { querySnapshot, error in
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
                switch change.type {
                case .added:
                    let request = Request(dictionary: change.document.data())
                    self.requestsDictionary[request.id ?? ""] = request
                case .modified:
                    let request = Request(dictionary: change.document.data())
                    self.requestsDictionary.removeValue(forKey: request.id ?? "")
                    self.requestsDictionary[request.id ?? ""] = request
                case .removed:
                    let request = Request(dictionary: change.document.data())
                    self.requestsDictionary.removeValue(forKey: request.id ?? "")
                }
            }
            self.sortRequestsByTimestamp(completion: completion)
        }
        return listener
    }
    
    
    private func sortRequestsByTimestamp(completion: @escaping (Bool) -> ()) {
        let values = Array(requestsDictionary.values)
        requests = values.sorted(by: { (request1, request2) -> Bool in
            guard let timestamp1 = request1.timestamp, let timestamp2 = request2.timestamp else { return false }
            return timestamp1.compare(timestamp2) == .orderedDescending
        })
        completion(true)
    }
}
