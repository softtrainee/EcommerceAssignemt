//
//  ProductListViewController.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit


protocol ProductListDisplayLogic: AnyObject {
    func presentProductList(viewModel: [ProductList.ProductModel]?)
    func navigateToProductDetail(product: ProductList.ProductModel)
    func updateNavbarBaskets()
    func notifyBasketProductCount()
    func setBasketButtonBadge()
}

class ProductListViewController: UIViewController, ProductListDisplayLogic, Alertable {
    var interactor: ProductListBusinessLogic?
    var router: (NSObjectProtocol & ProductListRoutingLogic & ProductListDataPassing)?
    private let navbarBasketButton = BadgeButton(image: UIImage(named: "navBarBasketItem") ?? UIImage())
    
    lazy var productListView = ProductListView()
    lazy var searchView = SearchTextField()
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ProductListInteractor()
        let presenter = ProductListPresenter()
        let router = ProductListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    func navigateToProductDetail(product: ProductList.ProductModel) {
        router?.product = product
        router?.navigateToProductDetail()
    }
    
    private let barButtonItem = UIBarButtonItem()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchView()
        configureProductListView()
        view.backgroundColor = .white
        setupNavbar()
        productListView.setCollectionViewDelegate(with: self, andDataSource: self)
        doSomething()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        interactor?.fetchBaskets()
    }
    
    private func configureSearchView() {
        let myView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        view.addSubview(myView)
        myView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            myView.widthAnchor.constraint(equalToConstant: view.frame.width),
            myView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        myView.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
       
            NSLayoutConstraint.activate([
                searchView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
                searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
                searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
                searchView.widthAnchor.constraint(equalToConstant: view.frame.width),
                searchView.heightAnchor.constraint(equalToConstant: 40)
            ])

        let tapGesture = UITapGestureRecognizer()
        myView.addGestureRecognizer(tapGesture)
            tapGesture.addTarget(self, action: #selector(didTapBackgroundView))
        searchView.searchDelegate = self
        }
    
    @objc private func didTapBackgroundView() {
        searchView.resignFirstResponder()
    }

    private func configureProductListView() {
        view.addSubview(productListView)
        productListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productListView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 16),
            productListView.widthAnchor.constraint(equalToConstant: view.frame.width),
            productListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    //MARK: - NavbarCofig
    private func setupNavbar() {
        let appearance = getNavigationBarAppearance()
        setNavigationBarAppearances(appearance: appearance)
        setupNavigationBar()
        addLogo()
    }
    private func getNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear

        
        return appearance
    }
    private func setNavigationBarAppearances(appearance: UINavigationBarAppearance) {
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func addLogo() {
        let logoImage = UIImage.init(named: "logo")
            let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.frame = CGRect(x: 16, y: 54, width: 152, height: 32)
        logoImageView.contentMode = .scaleAspectFit
            let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -25
            navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
    }
    
    
    func setupNavigationBar() {
            let logoImageView = navbarBasketButton
        logoImageView.frame = CGRect(x: 16, y: 59, width: 32, height: 20)
            logoImageView.contentMode = .scaleAspectFit
            let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            negativeSpacer.width = -25
         navbarBasketButton.addTarget(self, action: #selector(didTapBasketButton), for: .touchUpInside)
            navigationItem.rightBarButtonItems = [negativeSpacer, imageItem]
    }
    
    func doSomething() {
        interactor?.fetchProducts()
    }
    func presentProductList(viewModel: [ProductList.ProductModel]?) {
        interactor?.products = viewModel
        self.productListView.refresh()
    }
    
    @objc private func didTapBasketButton() {
        router?.navigateToBaskets()
    }
    
    func updateNavbarBaskets() {
        navbarBasketButton.setBadgeCount(count: Session.shared.basketCountNotification)
    }
    func notifyBasketProductCount() {
        interactor?.getBasketProductCount()
    }
    func setBasketButtonBadge() {
        navbarBasketButton.setBadgeCount(count: Session.shared.basketCountNotification)

    }
    
}

//MARK: - UICollectionViewDelegate
extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor?.didSelectItemAt(indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension ProductListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        interactor?.products?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ProductListCollectionViewCell else {
            fatalError("ProductListCollectionViewCell not found.")
        }
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = true
        cell.product = interactor?.productForIndexPath(indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ProductListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 1.02))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
        
    }
}
extension ProductListViewController: ProductListCollectionViewCellDelegate {
    func didTapAddBasket(_ product: ProductList.ProductModel?, piece: Int?) {
        interactor?.addBasket(product: product, piece: piece)
        showAlert(title: "Success", message: "Product has been added to basket.")
    }
}
extension ProductListViewController: SearchTextFieldDelegate {
    func textFieldDidBeginEditing(searchText: String?) {
        interactor?.searchProduct(searchText: searchText)
    }
}
