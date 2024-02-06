//
//  ProductListRouter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

@objc protocol ProductListRoutingLogic
{
    func navigateToProductDetail()
    func navigateToBaskets()
}

protocol ProductListDataPassing
{
    var dataStore: ProductListDataStore? { get }
    var product:  ProductList.ProductModel? { get set }
    
}

class ProductListRouter: NSObject, ProductListRoutingLogic, ProductListDataPassing
{
    var product: ProductList.ProductModel?
    weak var viewController: ProductListViewController?
    var dataStore: ProductListDataStore?
    
    // MARK: Navigation
    
    func navigateToProductDetail() {
        let vc  = ProductDetailViewController()
        vc.interactor?.viewModel = self.product
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    func navigateToBaskets() {
        let vc  = BasketsViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
