//
//  SignUpView+UIGesture.swift
//  EcommerceAssignemt
//
//  Created by Mohit Gupta on 04/02/24.
//

import UIKit

extension SignUpView{
    func setUpTapGestures(){
        let signInTapGesture = UITapGestureRecognizer(target: self, action: #selector(signInTapped))
        lblAlreadyHaveAccount.isUserInteractionEnabled = true
        lblAlreadyHaveAccount.addGestureRecognizer(signInTapGesture)
    }
    
    @objc func signInTapped(recognizer: UITapGestureRecognizer) {
        presenter?.signIn()
    }
}
