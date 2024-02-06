//
//  ProductListInteractor.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductListBusinessLogic
{
    func fetchProducts()
    func productForIndexPath(_ indexPath: IndexPath) -> ProductList.ProductModel?
    func didSelectItemAt(_ indexPath: IndexPath)
    func fetchBaskets()
    var products: [ProductList.ProductModel]? { get set }
    func addBasket(product: ProductList.ProductModel?, piece: Int?)
    func getBasketProductCount()
    func searchProduct(searchText: String?)
}

protocol ProductListDataStore
{
    //var name: String { get set }
    
}

class ProductListInteractor: ProductListBusinessLogic, ProductListDataStore
{
    var products: [ProductList.ProductModel]?
    
    var presenter: ProductListPresentationLogic?
    var worker: ProductListWorker?
    private var basketCountListener: BasketCountNotificationHandler = BasketCountNotificationHandler()
    
    func fetchProducts() {
        worker = ProductListWorker()
        let _ = worker?.fecthProducts(completion: { productModel in
            self.presenter?.presentProductList(viewModel: productModel )
        })
        
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> ProductList.ProductModel? {
        products?[indexPath.row]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        guard let product = products?[indexPath.row] else {
            return
        }
        presenter?.navigateToProductDetail(product: product)
    }
    
    func fetchBaskets() {
        worker = ProductListWorker()
//        let _ = worker?.fetchBaskets(completion: { productModel in
//            Session.shared.currentBasketCount = productModel?.count
//            Session.shared.basketCountNotification = productModel?.count
//            self.presenter?.updateNavbarBaskets()
//        })
    }
    func addBasket(product: ProductList.ProductModel?, piece: Int?) {
        worker = ProductListWorker()
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
    func searchProduct(searchText: String?) {
        worker = ProductListWorker()
        if searchText?.count ?? 0 > 2 {
            let _ = worker?.fetchSearchProduct(searchText, completion: { searchedProducts in
                self.presenter?.presentProductList(viewModel: searchedProducts )
            })
        } else {
            self.products = []
            self.fetchProducts()
        }
    }
}
