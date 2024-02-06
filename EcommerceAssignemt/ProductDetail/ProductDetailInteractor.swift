//
//  ProductDetailInteractor.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductDetailBusinessLogic
{
  var viewModel: ProductList.ProductModel? { get set }
  func getProductDetailModel()
  func viewDismiss()
  func addBasket(product: ProductList.ProductModel?, piece: Int?)
  func getBasketProductCount()
}

protocol ProductDetailDataStore
{
  //var name: String { get set }
}

class ProductDetailInteractor: ProductDetailBusinessLogic, ProductDetailDataStore
{
  var presenter: ProductDetailPresentationLogic?
  var worker: ProductDetailWorker?
  var viewModel: ProductList.ProductModel?
  private var basketCountListener: BasketCountNotificationHandler = BasketCountNotificationHandler()
  
  // MARK: Do something
  
    func getProductDetailModel() {
        guard let viewModel = self.viewModel else { return }
        presenter?.displayProductDetail(viewModel: viewModel)
    }
    func viewDismiss() {
        presenter?.viewDismiss()
    }
    func addBasket(product: ProductList.ProductModel?, piece: Int?) {
        worker = ProductDetailWorker()
        let _ = worker?.addBasket(product: product, piece: 1, completion: { bool in
            self.presenter?.productAddedToBasket()
            guard let currentBadgeCount = Session.shared.currentBasketCount else { return }
            BasketCountNotificationHandler.updateBasketCount(productCount:  currentBadgeCount + 1)
        })
    }
    
    func getBasketProductCount() {
        basketCountListener.handleUpdates = {
            self.presenter?.setBasketButtonBadge()
        }
    }
}
