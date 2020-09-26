import UIKit

class ProductDetialsVM {
    
    // MARK: Properties
    let product: Product
    
    var sizes: [String] = [] { didSet { isSizesAvailable() } }
    var selectedSize: String? { didSet { checkIsReadyToAddToBag() } }
    
    var bindableIsSizesAvailable = Bindable<Bool>()
    var bindalbeIsProductIsReady = Bindable<Bool>()
    
    
    // MARK: Initializers
    init(product: Product) {
        self.product = product
    }
}


// MARK: - Methods
extension ProductDetialsVM {
    
    func isSizesAvailable() {
        let isSizesAvailable = (sizes.count != 0)
        bindableIsSizesAvailable.value = isSizesAvailable
    }
    
    
    func checkIsReadyToAddToBag() {
        let isReady = selectedSize?.isEmpty == false
        bindalbeIsProductIsReady.value = isReady
    }
}
