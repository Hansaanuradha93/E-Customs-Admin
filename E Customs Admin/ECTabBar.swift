import UIKit

class ECTabBar: UITabBarController {

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [createHomeNC(), createAddProductNC(), createOrderListNC(), createRequestBoxNC()]
    }
}


// MARK: - Private Methods
extension ECTabBar {
    
    fileprivate func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.tabBarItem = UITabBarItem(title: "", image: Asserts.house, selectedImage: Asserts.houseFill)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    fileprivate func createAddProductNC() -> UINavigationController {
        let addProductVC = AddProductsVC()
        addProductVC.tabBarItem = UITabBarItem(title: "", image: Asserts.plus, selectedImage: Asserts.plus)
        return UINavigationController(rootViewController: addProductVC)
    }
    
    
    fileprivate func createOrderListNC() -> UINavigationController {
        let orderListVC = OrderListVC()
        orderListVC.tabBarItem = UITabBarItem(title: "", image: Asserts.document, selectedImage: Asserts.documentFill)
        return UINavigationController(rootViewController: orderListVC)
    }
    
    
    fileprivate func createRequestBoxNC() -> UINavigationController {
        let requestBoxVC = RequestBoxVC()
        requestBoxVC.tabBarItem = UITabBarItem(title: "", image: Asserts.envelope, selectedImage: Asserts.envelopeFill)
        return UINavigationController(rootViewController: requestBoxVC)
    }
}
