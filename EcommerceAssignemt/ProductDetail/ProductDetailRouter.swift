//
//  ProductDetailRouter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

@objc protocol ProductDetailRoutingLogic
{
    func viewDismiss()
    func navigateToBaskets()
}

protocol ProductDetailDataPassing
{
  var dataStore: ProductDetailDataStore? { get }
}

class ProductDetailRouter: NSObject, ProductDetailRoutingLogic, ProductDetailDataPassing
{
  weak var viewController: ProductDetailViewController?
  var dataStore: ProductDetailDataStore?


  // MARK: Navigation

    func viewDismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    func navigateToBaskets() {
        let vc  = BasketsViewController()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
