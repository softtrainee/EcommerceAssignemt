//
//  LoginView+LoginViewProtocol.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

//MARK: LoginViewProtocol Methods
extension LoginView: LoginViewProtocol {
    func showError(message: String) {
        print(message)
        presenter?.showAlert(message: message)
    }
    
    func showLoading() {
 
    }
    
    func hideLoading() {
 
    }
}
