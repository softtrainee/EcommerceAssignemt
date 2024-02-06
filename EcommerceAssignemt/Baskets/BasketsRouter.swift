//
//  BasketsRouter.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

@objc protocol BasketsRoutingLogic
{
    func viewDismiss()
}

protocol BasketsDataPassing
{
  var dataStore: BasketsDataStore? { get }
}

class BasketsRouter: NSObject, BasketsRoutingLogic, BasketsDataPassing
{
  weak var viewController: BasketsViewController?
  var dataStore: BasketsDataStore?
  
    func viewDismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
