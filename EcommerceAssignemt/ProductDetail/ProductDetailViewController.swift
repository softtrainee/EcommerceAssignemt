//
//  ProductDetailViewController.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol ProductDetailDisplayLogic: AnyObject
{
    func displaySomething(viewModel: ProductList.ProductModel)
    func displayProductDetail(viewModel: ProductList.ProductModel)
    func viewDismiss()
    func notifyBasketProductCount()
    func setBasketButtonBadge()
}

class ProductDetailViewController: UIViewController, ProductDetailDisplayLogic, Alertable
{
  var interactor: ProductDetailBusinessLogic?
  var router: (NSObjectProtocol & ProductDetailRoutingLogic & ProductDetailDataPassing)?
  private let productDetailView = ProductDetailView()

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ProductDetailInteractor()
    let presenter = ProductDetailPresenter()
    let router = ProductDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productDetailView.basketButton.setBadgeCount(count: Session.shared.basketCountNotification)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
  
  // MARK: Do something
  func doSomething()
  {
      view = productDetailView
      self.navigationController?.setNavigationBarHidden(true, animated: true)
      productDetailView.delegate = self
      interactor?.getProductDetailModel()
  }
  
  func displaySomething(viewModel: ProductList.ProductModel)
  {
  }
    func displayProductDetail(viewModel: ProductList.ProductModel) {
        productDetailView.product = viewModel
    }
    func viewDismiss() {
        router?.viewDismiss()
    }
    func notifyBasketProductCount() {
        interactor?.getBasketProductCount()
    }
    func setBasketButtonBadge() {
        productDetailView.basketButton.setBadgeCount(count: Session.shared.basketCountNotification)

    }
}

//MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
    func didTapDismiss() {
        interactor?.viewDismiss()
    }
    func didTapAddBasket(_ product: ProductList.ProductModel?, piece: Int?) {
        interactor?.addBasket(product: product, piece: piece)
        showAlert(title: "Success", message: "Product has been added to basket.")
    }
    func didTapDisplayBasket() {
        router?.navigateToBaskets()
    }
}
