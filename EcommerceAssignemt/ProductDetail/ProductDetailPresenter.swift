//
//  ProductDetailPresenter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductDetailPresentationLogic
{
  func presentSomething(response: ProductDetail.Something.Response)
    func displayProductDetail(viewModel: ProductList.ProductModel)
    func viewDismiss()
    func productAddedToBasket()
    func setBasketButtonBadge()
}

class ProductDetailPresenter: ProductDetailPresentationLogic
{
  weak var viewController: ProductDetailDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: ProductDetail.Something.Response)
  {
    
  }
    func displayProductDetail(viewModel: ProductList.ProductModel) {
        viewController?.displayProductDetail(viewModel: viewModel)
    }
    func viewDismiss() {
        viewController?.viewDismiss()
    }
   func productAddedToBasket() {
       viewController?.notifyBasketProductCount()
    }
    func setBasketButtonBadge() {
        viewController?.setBasketButtonBadge()
    }
}
