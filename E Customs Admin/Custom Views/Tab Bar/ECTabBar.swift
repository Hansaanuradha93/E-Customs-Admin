import UIKit

class ECTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}


// MARK: - Private Methods
private extension ECTabBar {
    
    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.house, selectedImage: Asserts.houseFill)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createAddProductNC() -> UINavigationController {
        let addProductVC = AddProductsVC()
        addProductVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.plus, selectedImage: Asserts.plus)
        return UINavigationController(rootViewController: addProductVC)
    }
    
    
    func createRequestBoxNC() -> UINavigationController {
        let requestBoxVC = RequestListVC()
        requestBoxVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.envelope, selectedImage: Asserts.envelopeFill)
        return UINavigationController(rootViewController: requestBoxVC)
    }
    
    
    func createOrderListNC() -> UINavigationController {
        let orderListVC = OrderListVC()
        orderListVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.document, selectedImage: Asserts.documentFill)
        return UINavigationController(rootViewController: orderListVC)
    }
    
    
    func createProfileNC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: Strings.empty, image: Asserts.person, selectedImage: Asserts.personFill)
        return UINavigationController(rootViewController: profileVC)
    }
    
    
    func setupUI() {
        UITabBar.appearance().tintColor = .black
        viewControllers = [createHomeNC(), createAddProductNC(), createRequestBoxNC(), createOrderListNC(), createProfileNC()]
        
        let traits = [UIFontDescriptor.TraitKey.weight: UIFont.Weight.medium]
        var descriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family: Fonts.avenirNext])
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: traits])
        let attributesForTitle = [NSAttributedString.Key.font: UIFont(descriptor: descriptor, size: 18)]
        let attributesForLargeTitle = [NSAttributedString.Key.font: UIFont(descriptor: descriptor, size: 28)]
        UINavigationBar.appearance().titleTextAttributes = attributesForTitle
        UINavigationBar.appearance().largeTitleTextAttributes = attributesForLargeTitle
        UINavigationBar.appearance().tintColor = .darkGray
    }
}
