import Firebase

final class ProductDetialsVM {
    
    // MARK: Properties
    let product: Product
    
    var sizes: [String] = [] { didSet { isSizesAvailable() } }
    var selectedSize: String? { didSet { checkIsReadyToAddToBag() } }
    
    var bindableIsSizesAvailable = Bindable<Bool>()
    var bindalbeIsProductIsReady = Bindable<Bool>()
    var bindableIsSaving = Bindable<Bool>()
    
    
    // MARK: Initializers
    init(product: Product) {
        self.product = product
    }
}


// MARK: - Public Methods
extension ProductDetialsVM {
    
    func addToBag(completion: @escaping (Bool, String) -> ()) {
        let currentUserId = Auth.auth().currentUser?.uid ?? ""
        let reference = Firestore.firestore().collection("bag").document(currentUserId).collection("items")
        guard let productID = product.id else {
            completion(false, Strings.somethingWentWrong)
            return
        }
        
        let itemReference = reference.document(productID)
        
        self.bindableIsSaving.value = true

        itemReference.getDocument { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                self.bindableIsSaving.value = false
                print(error.localizedDescription)
                completion(false, Strings.somethingWentWrong)
                return
            }
            
            if snapshot?.exists ?? false {
                self.bindableIsSaving.value = false
                completion(true, Strings.productAlreadyInBag)
            } else {
                let documentData : [String : Any] = [
                    "id" : productID,
                    "name" : self.product.name ?? "",
                    "description": self.product.description ?? "",
                    "price" : self.product.price ?? "",
                    "thumbnail" : self.product.thumbnailUrl ?? "",
                    "selectedSize": self.selectedSize ?? "0",
                    "quantity": 1
                ]

                itemReference.setData(documentData) { [weak self] error in
                    guard let self = self else { return }
                    self.bindableIsSaving.value = false

                    if let error = error {
                        print(error.localizedDescription)
                        completion(false, Strings.somethingWentWrong)
                        return
                    }

                    completion(true, Strings.productAddedToBag)
                }
            }
        }
    }
}


// MARK: - Private Methods
private extension ProductDetialsVM {
    
    func isSizesAvailable() {
        let isSizesAvailable = (sizes.count != 0)
        bindableIsSizesAvailable.value = isSizesAvailable
    }
    
    
    func checkIsReadyToAddToBag() {
        let isReady = selectedSize?.isEmpty == false && selectedSize != "0"
        bindalbeIsProductIsReady.value = isReady
    }
}
