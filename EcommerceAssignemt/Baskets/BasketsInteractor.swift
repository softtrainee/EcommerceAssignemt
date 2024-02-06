//
//  BasketsInteractor.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//



import UIKit

protocol BasketsBusinessLogic
{
    func fetchBaskets()
    func heightForRowAt() -> CGFloat
    func productForIndexPath(_ indexPath: IndexPath) -> ProductList.ProductModel?
    var products: [ProductList.ProductModel]? { get set }
    var numberOfRowsInSection: Int { get set }
    func deleteBaskets()
}

protocol BasketsDataStore
{
  //var name: String { get set }
}

class BasketsInteractor: BasketsBusinessLogic, BasketsDataStore
{
  var presenter: BasketsPresentationLogic?
  var worker: BasketsWorker?
    var numberOfRowsInSection: Int = 0
    var products: [ProductList.ProductModel]? {
        didSet {
            numberOfRowsInSection = products?.count ?? .zero
        }
    }
  
  // MARK: Do something
    func fetchBaskets() {
        worker = BasketsWorker()
        let _ = worker?.fetchBaskets(completion: { [self] productModel in
            presenter?.basketFetched(viewModel: productModel)
        })
    }
    func heightForRowAt() -> CGFloat {
        return 150
    }
    func productForIndexPath(_ indexPath: IndexPath) -> ProductList.ProductModel? {
        products?[indexPath.row]
    }
    func deleteBaskets() {
        worker = BasketsWorker()
        let _ = worker?.deleteBaskets(completion: { [self] productModel in
            presenter?.reloadData()
        })
    }
}
