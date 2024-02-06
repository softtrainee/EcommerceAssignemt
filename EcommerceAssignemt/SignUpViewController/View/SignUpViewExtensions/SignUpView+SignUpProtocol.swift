//
//  SignUpView+SignUpProtocol.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import Foundation

extension SignUpView: SignUpViewProtocol{
    
    func showError(message: String) {
        presenter?.showAlert(message: message)
    }
    
    func showLoading() {
 
    }
    
    func hideLoading() {
 
    }
}
