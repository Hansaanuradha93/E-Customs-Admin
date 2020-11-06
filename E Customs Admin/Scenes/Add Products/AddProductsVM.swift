import UIKit
import Firebase

final class AddProductsVM {
    
    // MARK: Properties
    var name: String? { didSet { checkFormValidity() } }
    var description: String? { didSet { checkFormValidity() } }
    var price: String? { didSet { checkFormValidity() } }
    var sizes: String? { didSet { checkFormValidity() } }
    
    
    // MARK: Bindlable
    var bindableImage = Bindable<UIImage>()
    var bindalbeIsFormValid = Bindable<Bool>()
    var bindableIsSaving = Bindable<Bool>()
}


// MARK: - Public Methods
extension AddProductsVM {
    
    func saveImageToFirebase(completion: @escaping (Bool, String) -> ()) {
        guard let image = self.bindableImage.value,
        let uploadData = image.jpegData(compressionQuality: 0.75) else { return }
        self.bindableIsSaving.value = true
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(filename)")
        
        storageRef.putData(uploadData, metadata: nil) { (_, error) in
            if let error = error {
                self.bindableIsSaving.value = false
                print(error.localizedDescription)
                completion(false, Strings.somethingWentWrong)
                return
            }
            self.fetchImageDownloadUrl(reference: storageRef, completion: completion)
        }
    }
    
    
    func checkFormValidity() {
        let isFormValid = name?.isEmpty == false && description?.isEmpty == false && price?.isEmpty == false && sizes?.isEmpty == false && bindableImage.value != nil
        bindalbeIsFormValid.value = isFormValid
    }
}


// MARK: - Fileprivate Methods
fileprivate extension AddProductsVM {
    
    func fetchImageDownloadUrl(reference: StorageReference, completion: @escaping (Bool, String) -> ()) {
        reference.downloadURL { (url, error) in
            if let error = error {
                self.bindableIsSaving.value = false
                print(error.localizedDescription)
                completion(false, Strings.somethingWentWrong)
                return
            }
            let downloadUrl = url?.absoluteString ?? ""
            self.saveInfoToFirestore(imageUrl: downloadUrl, completion: completion)
        }
    }
    
    
    func saveInfoToFirestore(imageUrl: String, completion: @escaping (Bool, String) -> ()) {
        let reference = Firestore.firestore().collection("products")
        let documentId = reference.document().documentID
        
        let productInfo: [String: Any] = [
            "id": documentId,
            "name": (name ?? "").uppercased(),
            "description": description ?? "",
            "price": price ?? "0",
            "sizes": sizes ?? "",
            "thumbnailUrl": imageUrl
        ]
        
        reference.document(documentId).setData(productInfo) { [weak self] error in
            guard let self = self else { return }
            self.bindableIsSaving.value = false
            if let error = error {
                print(error.localizedDescription)
                completion(false, Strings.somethingWentWrong)
                return
            }
            completion(true, Strings.productSaved)
        }
    }
}
