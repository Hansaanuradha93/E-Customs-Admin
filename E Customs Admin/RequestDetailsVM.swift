import UIKit
import Firebase

class RequestDetailsVM {
    
    // MARK: Properties
    var price: String? { didSet { checkFormValidity() } }

    
    // MARK: Bindables
    var bindableIsApproving = Bindable<Bool>()
    var bindalbeIsFormValid = Bindable<Bool>()
}


// MARK: - Methods
extension RequestDetailsVM {
    
    func approve(request: Request, completion: @escaping (Bool, String) -> ()) {
        guard let id = request.id else { return }
        self.bindableIsApproving.value = true
        let reference = Firestore.firestore().collection("requests").document(id)

        let data: [String: Any] = [
            "isApproved": true,
            "price": Double(price ?? "0") ?? 0
        ]
        
        reference.updateData(data) { error in
            self.bindableIsApproving.value = false
            if let error = error {
                print(error)
                completion(false, error.localizedDescription)
                return
            }
            completion(true, "Request updated successfully")
        }
    }
    
    
    func checkFormValidity() {
        let isFormValid = price?.isEmpty == false
        bindalbeIsFormValid.value = isFormValid
    }
}
