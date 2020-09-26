import UIKit

class ProductDetialsVM {
    
    // MARK: Properties
    let product: Product
    
    var sizes: [String] = [] { didSet { isSizesAvailable() } }
    
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
    
    
    func checkFormValidity() {
        let isProductIsReady = sizes.isEmpty == false
        bindalbeIsProductIsReady.value = isProductIsReady
    }
}
