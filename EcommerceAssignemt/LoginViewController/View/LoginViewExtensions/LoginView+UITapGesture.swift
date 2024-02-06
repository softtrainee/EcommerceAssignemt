//
//  LoginView+UITapGesture.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

extension LoginView{
    func setUpTapGestures(){
        let forgetPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(forgetPasswordTapped))
        lblForgetPassword.isUserInteractionEnabled = true
        lblForgetPassword.addGestureRecognizer(forgetPasswordTapGesture)
        
        let signUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        lblDontHaveAnAccount.isUserInteractionEnabled = true
        lblDontHaveAnAccount.addGestureRecognizer(signUpTapGesture)
    }
    
    @objc func forgetPasswordTapped(recognizer: UITapGestureRecognizer) {
        presenter?.forgetPassword()
    }
    
    @objc func signUpTapped(recognizer: UITapGestureRecognizer) {
        presenter?.signup()
    }
}
