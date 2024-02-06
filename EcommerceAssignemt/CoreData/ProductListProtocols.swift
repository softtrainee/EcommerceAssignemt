//
//  ProductListProtocols.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductListViewProtocol: AnyObject {
    var presenter: ProductListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showProducts(with products: [ProductList.ProductModel])
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol ProductListWireFrameProtocol: AnyObject {
    static func createProductListModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentProductDetailScreen(from view: ProductListViewProtocol, forProduct product: ProductList.ProductModel)
}

protocol ProductListPresenterProtocol: AnyObject {
    var view: ProductListViewProtocol? { get set }
    var interactor: ProductListInteractorInputProtocol? { get set }
    var wireFrame: ProductListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showProductDetail(forProduct product: ProductList.ProductModel)
}

protocol ProductListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func didRetrieveProducts(_ products: [ProductList.ProductModel])
    func onError()
}

protocol ProductListInteractorInputProtocol: AnyObject {
    var presenter: ProductListInteractorOutputProtocol? { get set }
    var localDatamanager: ProductListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ProductListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveProductList()
}

protocol ProductListDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol ProductListRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: ProductListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveProductList()
}

protocol ProductListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onProductsRetrieved(_ products: [ProductList.ProductModel])
    func onError()
}

protocol ProductListLocalDataManagerInputProtocol: AnyObject {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveProductList() throws -> [Product]
    func saveProduct(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
