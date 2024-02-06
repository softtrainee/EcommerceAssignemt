//
//  ShowAlert.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

func showAlertWithMessage(view: UIViewController , message: String){
    let alertView: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
    let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
    alertView.addAction(alertAction)
    view.present(alertView, animated: true, completion: nil)
}

func showAlertWithMessageAndDismiss(currentView view: UIViewController , message: String){
    let alertView: UIAlertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
    let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel){ _ in
        view.navigationController?.popViewController(animated: true)
    }
    alertView.addAction(alertAction)
    view.present(alertView, animated: true, completion: nil)
}
