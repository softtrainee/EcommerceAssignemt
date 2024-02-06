//
//  ProductListPresenter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductListPresentationLogic
{
    func presentProductList(viewModel: [ProductList.ProductModel]?)
    func navigateToProductDetail(product: ProductList.ProductModel)
    func updateNavbarBaskets()
    func productAddedToBasket()
    func setBasketButtonBadge()
}

class ProductListPresenter: ProductListPresentationLogic
{
    weak var viewController: ProductListDisplayLogic?
    
    func presentProductList(viewModel: [ProductList.ProductModel]?) {
        viewController?.presentProductList(viewModel: viewModel)
    }
    func navigateToProductDetail(product: ProductList.ProductModel) {
        viewController?.navigateToProductDetail(product: product)
    }
    func updateNavbarBaskets() {
        viewController?.updateNavbarBaskets()
    }
    func productAddedToBasket() {
        viewController?.notifyBasketProductCount()
    }
    func setBasketButtonBadge() {
        viewController?.setBasketButtonBadge()
    }
}
