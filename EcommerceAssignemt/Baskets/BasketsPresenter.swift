//
//  BasketsPresenter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

protocol BasketsPresentationLogic
{
    func basketFetched(viewModel: [ProductList.ProductModel]?)
    func reloadData()
}

class BasketsPresenter: BasketsPresentationLogic
{
  weak var viewController: BasketsDisplayLogic?
  
  // MARK: Do something
    
    func basketFetched(viewModel: [ProductList.ProductModel]?) {
        viewController?.presentBasketList(viewModel: viewModel)
    }
    func reloadData() {
        viewController?.reloadData()
    }
}
