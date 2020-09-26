import UIKit
import Firebase

class AddProductsVM {
    
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


// MARK: - Methods
extension AddProductsVM {
    
    func saveImageToFirebase(completion: @escaping ((Error?) -> ())) {
        guard let image = self.bindableImage.value,
        let uploadData = image.jpegData(compressionQuality: 0.75) else { return }
        self.bindableIsSaving.value = true
        let filename = UUID().uuidString
        let storageRef = Storage.storage().reference().child("images/\(filename)")
        
        storageRef.putData(uploadData, metadata: nil) { (_, error) in
            if let error = error {
                self.bindableIsSaving.value = false
                completion(error)
                return
            }
            self.fetchImageDownloadUrl(reference: storageRef, completion: completion)
        }
    }
    
    
    fileprivate func fetchImageDownloadUrl(reference: StorageReference, completion: @escaping (Error?) -> ()) {
        reference.downloadURL { (url, error) in
            if let error = error {
                self.bindableIsSaving.value = false
                completion(error)
                return
            }
            let downloadUrl = url?.absoluteString ?? ""
            self.saveInfoToFirestore(imageUrl: downloadUrl, completion: completion)
        }
    }
    
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> ()) {
        let reference = Firestore.firestore().collection("products")
        let documentId = reference.document().documentID
        
        let productInfo: [String: Any] = [
            "id": documentId,
            "name": name ?? "",
            "description": description ?? "",
            "price": price ?? "0",
            "sizes": sizes ?? "",
            "thumbnailUrl": imageUrl
        ]
        
        reference.document(documentId).setData(productInfo) { [weak self] error in
            guard let self = self else { return }
            self.bindableIsSaving.value = false
            if let error = error {
                completion(error)
                return
            }
            print("Product save successfully")
            completion(nil)
        }
    }
    
    
    func checkFormValidity() {
        let isFormValid = name?.isEmpty == false && description?.isEmpty == false && price?.isEmpty == false && sizes?.isEmpty == false && bindableImage.value != nil
        bindalbeIsFormValid.value = isFormValid
    }
}
