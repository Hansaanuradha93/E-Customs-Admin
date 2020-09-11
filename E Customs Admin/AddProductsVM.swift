import UIKit

class AddProductsVM {
    
    // MARK: Properties
    var name: String? { didSet { checkFormValidity() } }
    var price: String? { didSet { checkFormValidity() } }
    var sizes: String? { didSet { checkFormValidity() } }
    
    // MARK: Bindlable
    var bindableImage = Bindable<UIImage>()
    var bindalbeIsFormValid = Bindable<Bool>()
    var bindableIsSaving = Bindable<Bool>()
}


// MARK: - Methods
extension AddProductsVM {
    
    func checkFormValidity() {
        let isFormValid = name?.isEmpty == false && price?.isEmpty == false && sizes?.isEmpty == false && bindableImage.value != nil
        bindalbeIsFormValid.value = isFormValid
    }
}
