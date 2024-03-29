//
//  BasketsViewController.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol BasketsDisplayLogic: AnyObject
{
  func presentBasketList(viewModel: [ProductList.ProductModel]?)
    func reloadData()
}

class BasketsViewController: UIViewController, BasketsDisplayLogic, Alertable
{
  var interactor: BasketsBusinessLogic?
  var router: (NSObjectProtocol & BasketsRoutingLogic & BasketsDataPassing)?
    
  private let basketView = BasketView()

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
    let interactor = BasketsInteractor()
    let presenter = BasketsPresenter()
    let router = BasketsRouter()
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
    setupLeftBarItem()
    setupNavigationBar()
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }
    func setupLeftBarItem() {
        let label = UILabel()
        label.text = "My Cart"
        label.font = .latoSemiBold14
        label.textColor = .black
        let leftItem = UIBarButtonItem(customView: label)
        
        let logoImage = UIImage.init(named: "backIcon")
        let logoImageView = UIImageView.init(image: logoImage)
        let tapGesture = UITapGestureRecognizer()
        logoImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(didTapBackButton))
    
        logoImageView.frame = CGRect(x: 16, y: 54, width: 12, height: 12)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -25
            navigationItem.leftBarButtonItems = [negativeSpacer, imageItem, leftItem]
    }
    
    func setupNavigationBar() {
        let label = UILabel()
        label.text = "Delete All"
        label.font = .latoSemiBold14
        label.textColor = UIColor(named: "buttonPinkColor")
        let tapGesture = UITapGestureRecognizer()
        label.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(didTapDelete))
        let leftItem = UIBarButtonItem(customView: label)
        self.navigationItem.rightBarButtonItem = leftItem
    }
    
  // MARK: Do something
  func doSomething()
  {
      view = basketView
      basketView.delegate = self
      basketView.setTableViewDelegate(self, andDataSource: self)
      interactor?.fetchBaskets()
  }

    func presentBasketList(viewModel: [ProductList.ProductModel]?) {
        interactor?.products = viewModel
        basketView.product = interactor?.products
        basketView.reloadTableView()
    }
    
    func reloadData() {
        basketView.reloadTableView()
    }
    
    @objc private func didTapDelete() {
        interactor?.deleteBaskets()
    }
    @objc private func didTapBackButton() {
        router?.viewDismiss()
    }
}
extension BasketsViewController: BasketViewDelegate {
    func didTapBuyButton() {
        showAlert(title: "Pay",
                  message: "Do you want to complete the purchase?",
                  cancelButtonTitle: "Cancel") { _ in
        }
    }
}
//MARK: - BasketTableViewCellDelegate
extension BasketsViewController: BasketTableViewCellDelegate {
    func didTapDeleteButton(_ basket: ProductList.ProductModel??) {
        
    }
    
    func didTapStepper(_ basket: ProductList.ProductModel??, piece: Double?) {
        
    }
    
    func didTapStepper(_ basket: ProductList.ProductModel?, piece: Double?) {
    }
    
    func didTapDeleteButton(_ basket: ProductList.ProductModel?) {

    }
}

//MARK: - UITableViewDelegate
extension BasketsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        interactor?.heightForRowAt() ?? 150
    }
}

//MARK: - UITableViewDataSource
extension BasketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.numberOfRowsInSection ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BasketTableViewCell else {
            fatalError("BasketTableViewCell not found")
        }
        cell.basket = interactor?.productForIndexPath(indexPath)
        cell.delegate = self
        return cell
    }
}
