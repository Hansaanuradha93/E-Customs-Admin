import UIKit
import Firebase

final class SignupVM {
    
    // MARK: Properties
    var firstName: String? { didSet { checkFormValidity() } }
    var lastName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    var isMale: Bool? { didSet {
        checkFormValidity()
        checkGender()
    } }
    
    
    // MARK: Bindlable
    var bindalbeIsFormValid = Bindable<Bool>()
    var bindableIsMaleSelected = Bindable<Bool>()
    var bindableIsRegistering = Bindable<Bool>()
}


// MARK: - Public Methods
extension SignupVM {
    
    func performSignUp(completion: @escaping (Bool, String) -> ()) {
        guard let email = email, let password = password else { return }
        self.bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                self.bindableIsRegistering.value = false
                completion(false, error.localizedDescription)
                return
            }
            self.saveInfoToFirestore(completion: completion)
        }
    }
}


// MARK: - Private Methods
private extension SignupVM {
    
    func saveInfoToFirestore(completion: @escaping (Bool, String) -> ()) {
        let uid = Auth.auth().currentUser?.uid ?? ""
        let userInfo = [
            "uid": uid,
            "email": email ?? "",
            "firstname": firstName ?? "",
            "lastname": lastName ?? "",
            "isMale": isMale ?? false,
            "isAdminUser": true
            ] as [String : Any]
        
        Firestore.firestore().collection("users").document(uid).setData(userInfo) { [weak self] error in
            guard let self = self else { return }
            self.bindableIsRegistering.value = false
            if let error = error {
                print(error.localizedDescription)
                completion(false, Strings.somethingWentWrong)
                return
            }
            completion(true, Strings.authenticationSuccessfull)
        }
    }
    
    
    func checkFormValidity() {
        let isFormValid = firstName?.isEmpty == false && lastName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false && password?.count ?? 0 >= 6 && isMale != nil
        bindalbeIsFormValid.value = isFormValid
    }
    
    
    func checkGender() {
        bindableIsMaleSelected.value = isMale
    }
}
